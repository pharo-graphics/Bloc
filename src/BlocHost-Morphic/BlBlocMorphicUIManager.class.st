"
I provide a solution for handling the opening of the Morphic debugger in the Morphic UI process when errors happen in either the Bloc UI process and the Morphic UI Process.

I explicitly spawn a Morphic-based debugger on either a Bloc or a Morphic UI process depending on where the error occured and close the created process on resume. 
Because of this I am meant to be used only with a debugger based on Morphic that runs inside the Morphic UI Process. A debugger written in Bloc will not work correctly with this UI Manager.

I handle exceptions in the Morphic UI process the same as ${class:MorphicUIManager}$. However, I also have support for handling errors in the Bloc UI Process in spite of the fact that the actual debugger is only aware of a single UI process. I also do not require to override any methods from Pharo. My design could be improved by changing the way a ${class:DebugSession}$ handles the UI process to not hardcode actions on the UI process but dispatch actions relevant for the UI process through the UIManager.

I need to override the method ${method:MorphicUIManager>>#resumeUIProcess:}$ to handle the Bloc UI process in a special way. This is because the ${method:DebugSession>>#terminate}$ terminates the current process if the error was in the Morphic UI process. This is because if the error happened in the Morphic UI process, that process is suspended and a new Morphic UI process is started that runs the debugger. When the debugger is resumed the current Morphic UI process that was created for running the debugger should be suspended, and the process where the error happened that was initialy interruped should be resumed. If the error was in the Bloc UI process, terminating the current process will terminate the only Morphic UI process that is currently running the debugger. This happens as now the ${method:DebugSession>>#errorWasInUIProcess}$ is set to true if the error was in either the Bloc or Morhic UI process. Then ${method:DebugSession>>#terminate}$ terminates the current process if ${method:DebugSession>>#isAboutUIProcess}$ returns true. 

I use ==Smalltalk tools debugger== to open the actual debugger. For my preconditions to hold this needs to be a Morphic based debugger. 
"
Class {
	#name : #BlBlocMorphicUIManager,
	#superclass : #MorphicUIManager,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #actions }
BlBlocMorphicUIManager class >> isActiveManager [
	^ false
]

{ #category : #actions }
BlBlocMorphicUIManager class >> useAsDefault [
	|uiManager|
	uiManager := self new.
	uiManager beDefault. 
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> blocDefer: aBlock [
	| aGlutinUniverse |

	aBlock value

	"aGlutinUniverse := BlParallelUniverse forHost: Bloc preferableHostClass.
	aGlutinUniverse defer: aBlock"
]

{ #category : #debug }
BlBlocMorphicUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
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
			ifTrue:[ self spawnNewBlocProcess: aBlocUniverseIfAny ]
			ifFalse: [ self spawnNewMorphicProcess ] ] ].

	"Perform the opening of the debugger using the registered debugger. This can be either a Morphic or Bloc based debugger."
	self defer: [ 
		[ Smalltalk tools debugger 
			openOn: debugSession withFullView: bool andNotification: notificationString.
		] on: Error do: [ :ex | 	debugSession signalDebuggerError: ex ] ].
	
	process suspend.

]

{ #category : #debug }
BlBlocMorphicUIManager >> isBlocUIProcess: aProcess [
	^ BlParallelUniverse all anySatisfy: [ :eachUniverse |
		| isInterruptedProcess |
		isInterruptedProcess := false.
	
		eachUniverse hostClass uiProcessDo: [ :eachUIProcess |
			isInterruptedProcess := eachUIProcess name = aProcess name ].
		isInterruptedProcess ]
]

{ #category : #debug }
BlBlocMorphicUIManager >> isForBlocUIProcess: debugSession [
	^ BlParallelUniverse all anySatisfy: [ :eachUniverse |
		| isInterruptedProcess |
		isInterruptedProcess := false.
	
		eachUniverse hostClass uiProcessDo: [ :eachUIProcess |
			isInterruptedProcess := eachUIProcess == debugSession interruptedProcess ].
		isInterruptedProcess ]
]

{ #category : #'ui requests' }
BlBlocMorphicUIManager >> request: aStringOrText initialAnswer: defaultAnswer title: aTitle [ 
	^ super request: aStringOrText initialAnswer: defaultAnswer title: aTitle
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeBlocUIProcess: aProcess [
	"Adopt aProcess as the UI process for Bloc -- probably because of proceeding from a debugger"
			
	"The Bloc UI process needs to be handled in a special way. The current debugger only knows about the existance of a single UI process.
	Hence, on resume the debugger tries to terminate the active UI process using ==Processor terminateActive== (DebugSession>>#terminate).
	While that works for the Morpic UI process, it will not work for the Bloc UI process, as the debugger for the Bloc UI process runs inside the Morphic UI process.
	Instead I do all the work of closing and resuming the correct Bloc UI process"
	|currentDebugSession|
		
	BlUniverse default pulseLoop loopProcess terminate. "Terminate the current Bloc UI process"
	BlUniverse default pulseLoop forceStartOfUIProcess: aProcess. "Start the given process as the current Bloc UI process"
		
	"This is the only hack I found to make the debugger not terminate the current active process on close.
	In DebugSession>>#terminate the debugger terminates the active process if the errorWasInUIProcess attribute is set to true.
	Here we set it to false to tell the debugger that the Bloc UI process is not the current UI process from the system."
	currentDebugSession := thisContext sender sender receiver. 
	currentDebugSession errorWasInUIProcess: false.
			
	
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeMorphicUIProcess: aProcess [
	"Adopt aProcess as the UI process for morphic -- probably because of proceeding from a debugger"
			
	"Resume the Morphic UI process normally without any special logic. 
	This assumes that the debugger was opened and runs in the Morphic UI process."
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeUIProcess: aProcess [
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"
	
	"I explicitly check if the process corresponds to the Bloc UI process or not so I can determine which UI process to resume."
	"For now the only way to determine if the process given as a parameter was a Bloc UI process is by checking the process name."
	(self isBlocUIProcess: aProcess)
		ifTrue:  [ 
			"Resume the Bloc UI process."
			self resumeBlocUIProcess: aProcess ]
		ifFalse: [ 
			"Resume the Moprhic UI process."
			self resumeMorphicUIProcess: aProcess ]
		
	
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewBlocProcess [
	BlUniverse default pulseLoop forceStartNewUIProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewBlocProcess: aUniverse [
	aUniverse stopPulsation.
	aUniverse hostClass forceStartNewUIProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewMorphicProcess [
	self spawnNewProcess
]

{ #category : #debug }
BlBlocMorphicUIManager >> universeForProcess: aProcess ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
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

{ #category : #debug }
BlBlocMorphicUIManager >> universeForSession: debugSession ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
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
