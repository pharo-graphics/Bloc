"
I provide a solution for handling the opening of the debugger that supports both the Bloc UI and the Morphic UI processes.

I assume there is only one UI Process either in Bloc or Morphic. If the error happened in either one of these processes, I restart the correct one. If both Bloc and Morphic have two distinct UI processes I will not work correctly.

Normally I should only be used when running Bloc natively. When running Bloc using inside the Morphic UI process the a ${class:MorphicUIManager}$ can be used instead.
However for now I can also be used to handle just the case of the Morhic UI process. Later I should be simplified to take into account only the Bloc UI process.
"
Class {
	#name : #BlBlocUIManager,
	#superclass : #MorphicUIManager,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'class initialization' }
BlBlocUIManager class >> handledId [
	^ self name
]

{ #category : #'class initialization' }
BlBlocUIManager class >> initialize [
	"has to be executed at the end of the user category"
	SessionManager default 
		register: self
		inCategory: SessionManager default userCategory  
		atPriority: SmallInteger maxVal + 1
]

{ #category : #testing }
BlBlocUIManager class >> isValidForCurrentSystemConfiguration [
	| isHeadlessVM isInteractiveMode |
	
	isHeadlessVM := Smalltalk os windowSystemName isNil or: [ Smalltalk os windowSystemName = 'null' ].
	
	"The --interactive parameter should be passed in order to select a graphical UI manager.
	This parameter is passe automatically when double clicking on the Headless VM."
	isInteractiveMode := CommandLineArguments new hasOption: 'interactive'.
		
	^ isHeadlessVM and: [ isInteractiveMode ]
]

{ #category : #'class initialization' }
BlBlocUIManager class >> shutdown: isImageQuitting [
	"Prepare the shutdown and the next startup"

	UIManager default: StartupUIManager new
	
]

{ #category : #'class initialization' }
BlBlocUIManager class >> startup: isImageStarting [
	"Install the right UIManager"
	
	UIManager default: (self isValidForCurrentSystemConfiguration
		ifTrue: [ self new ]
		ifFalse: [ UIManager forCurrentSystemConfiguration ])
]

{ #category : #actions }
BlBlocUIManager class >> useAsDefault [
	|uiManager|
	uiManager := self new.
	uiManager beDefault. 
]

{ #category : #debug }
BlBlocUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
	"Open the default debugger registered in the system as a result of the error."
	self 
		debugProcess: process 
		context: context 
		label: title 
		spawningDebuggingUsing: [ :debugSession | 
			Smalltalk tools debugger 
				openOn: debugSession withFullView: bool andNotification: notificationString ]
]

{ #category : #debug }
BlBlocUIManager >> debugProcess: process context: context label: title spawningDebuggingUsing: debuggerSpawnBlock [
	"I open the default debugger and add support for detecting if the 
	debugged process is the Morphic or Bloc UI process.
	I spawn a new Bloc UI process if the debugged process is the Bloc UI process 
	or a Morphic UI process if the debugged process is the Morphic UI process."
	| debugSession isForBlocUIProcess aBlocUniverseIfAny |
	
	debugSession := process newDebugSessionNamed: title startedAt: context.
	debugSession logStackToFileIfNeeded.
	
	isForBlocUIProcess := false.
	aBlocUniverseIfAny := nil.
	
	self
		universeForSession: debugSession
		ifPresent: [ :aUniverse |
			isForBlocUIProcess := true.
			aBlocUniverseIfAny := aUniverse.
			debugSession errorWasInUIProcess: true ]
		ifAbsent: [].
	
	debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
		isForBlocUIProcess "Handle the case of the Bloc UI process"
			ifTrue: [ self spawnNewBlocProcess: aBlocUniverseIfAny ]
			ifFalse: [ self spawnNewProcess ] ] ].
	
	"Perform the opening of the debugger in defer action to suspend the UI."
	self defer: [ 
		[ 
			debuggerSpawnBlock value: debugSession.
		] on: Error do: [ :ex | 	
			debugSession signalDebuggerError: ex ] ].
	
	process suspend.

]

{ #category : #'ui process' }
BlBlocUIManager >> defer: aBlock [
	| theUniversesWithUIProcess |

	theUniversesWithUIProcess := (BlParallelUniverse all select: [ :eachUniverse |
			eachUniverse hasSpaces
				and: [ eachUniverse hasUIProcess
					and: [ eachUniverse hostClass new isRunning ] ] ])
		sorted: [ :a :b | a hostClass priority < b hostClass priority ].

	theUniversesWithUIProcess
		ifEmpty: [ super defer: aBlock ]
		ifNotEmpty: [ :theUniverses | theUniverses first defer: aBlock ]
]

{ #category : #'ui process' }
BlBlocUIManager >> isBlocUIProcess: aProcess [ 
	"Check if the given process is a Bloc UI process.
	We consider it a Bloc UI process if is the UI process of a Universe."
	self 
		universeForProcess: aProcess 
		ifPresent: [ :processUniverse | ^ true ] 
		ifAbsent: [ ^ false ].
	^ false
]

{ #category : #events }
BlBlocUIManager >> onPrimitiveError: aString [ 
	| message |

	message := String
				streamContents: [:s | 
					| context |
					s nextPutAll: '*** System error handling failed ***'.
					s cr; nextPutAll: aString.
					context := thisContext sender sender.
					20
						timesRepeat: [context == nil
								ifFalse: [s cr; print: (context := context sender)]]].
	GtEmergencyDebugger askForEmergencyEvaluatorOrExitWithText: message.

]

{ #category : #'ui process' }
BlBlocUIManager >> resumeBlocUIProcess: aProcess [
	"Adopt aProcess as the UI process for Bloc -- probably because of proceeding from a debugger"

	"Resume the Bloc UI process normally by delegating the resume operation through the host. 
	This assumes that the debugger was opened and runs in the Bloc UI process.
	In case Bloc is embedded inside the Morphic World, the Bloc UI process is going to
	be the Morphic UI process. Delegating the process operations through the host
	ensures that the Morphic UI process will be resumed correctly."
	
	self
		universeForProcess: aProcess
		ifPresent: [ :aUniverse |
			"aUniverse stopPulsation." 
			aUniverse hostClass forceResumeOfUIProcess: aProcess ]
		ifAbsent: [  ].
]

{ #category : #'ui process' }
BlBlocUIManager >> resumeMorphicUIProcess: aProcess [ 
	"Adopt aProcess as the UI process for morphic -- probably because of proceeding from a debugger"

	"Resume the Morphic UI process normally without any special logic. 
	This assumes that the debugger was opened and runs in the Morphic UI process."
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'ui process' }
BlBlocUIManager >> resumeUIProcess: aProcess [
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"

	"I explicitly check if the process corresponds to the Bloc UI process or not so I can determine which UI process to resume."
	(self isBlocUIProcess: aProcess)
		ifTrue:  [ 
			"Resume the Bloc UI process."
			self resumeBlocUIProcess: aProcess ]
		ifFalse: [ 
			"Resume the Moprhic UI process."
			self resumeMorphicUIProcess: aProcess ]
]

{ #category : #debug }
BlBlocUIManager >> spawnNewBlocProcess: aUniverse [
	aUniverse stopPulsation.
	aUniverse hostClass forceStartNewUIProcess
]

{ #category : #'default actions' }
BlBlocUIManager >> unhandledErrorDefaultAction: anException [

	"The current computation is terminated. The cause of the error should be logged or reported to the user. If the program is operating in an interactive debugging environment the computation should be suspended and the debugger activated."
	anException debug
]

{ #category : #'ui process' }
BlBlocUIManager >> universeForProcess: aProcess ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
	^ BlParallelUniverse all
		detect: [ :eachUniverse |
			| isInterruptedProcess |
			isInterruptedProcess := false.
			eachUniverse hostClass
				uiProcessDo: [ :eachUIProcess | isInterruptedProcess := eachUIProcess name = aProcess name ].
			isInterruptedProcess ]
		ifFound: aPresentBlock
		ifNone: anExceptionBlock
]

{ #category : #'ui process' }
BlBlocUIManager >> universeForSession: debugSession ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
	^ BlParallelUniverse all
		detect: [ :eachUniverse |
			| isInterruptedProcess |
			isInterruptedProcess := false.
			eachUniverse hostClass
				uiProcessDo: [ :eachUIProcess | isInterruptedProcess := eachUIProcess == debugSession interruptedProcess ].
			isInterruptedProcess ]
		ifFound: aPresentBlock
		ifNone: anExceptionBlock
]
