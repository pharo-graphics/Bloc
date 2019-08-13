"
I provide a solution for handling the opening of a Bloc debugger in the Bloc UI process when errors happen in either the Bloc UI process and any other Process.

I should only be used with debuggers that run inside the Bloc UI process. I allways spawn a Bloc debugger on errors that happen either in the Bloc UI process or the Morphic UI process. 
I know how to correctly resume the Morphic UI process even if the actual debugger runs in the Bloc UI process.

I use ==Smalltalk tools debugger== to open the actual debugger. For my preconditions to hold this needs to be a Bloc based debugger. 

See the comment of my superclass for more details.
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
	^ Smalltalk isHeadless and: [ 
		"Condition that if true we asume that the user does not need an UI.
		If that case this UI manager should not be activated."
		({'examples' . 'releasegtoolkit'} includes: (Smalltalk vm getSystemAttribute: 2)) not or: [
			(Smalltalk commandLine arguments includes: '--junit-xml-output') not ] ]
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
	"I open the default debugger and add support for detecting if the 
	debugged process is the Morphic or Bloc UI process.
	I spawn a new Bloc UI if the debugged process is the Bloc UI process 
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

	"Perform the opening of the debugger using the registered debugger. This must be a Bloc based debugger."
	self defer: [ 
		[ Smalltalk tools debugger 
			openOn: debugSession withFullView: bool andNotification: notificationString.
		] on: Error do: [ :ex | 	debugSession signalDebuggerError: ex ] ].
	
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
			
	"This UI manager resumes the Bloc UI proces normally. 
	It assumes the debugger was opened and runs in the Bloc UI process."
	
	self
		universeForProcess: aProcess
		ifPresent: [ :aUniverse | aUniverse hostClass forceResumeOfUIProcess: aProcess ]
		ifAbsent: [  ]
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
