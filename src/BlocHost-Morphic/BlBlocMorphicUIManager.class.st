"
I provide a solution for handling the opening of the debugger when errors happen in both the Bloc UI process and the Morphic UI Process.

I explicitly spawn a Morphic-based debugger on either a Bloc or a Morphic UI process depending on where the error occured and close the created process on resume. 
Because of this I am meant to be used only with a debugger based on Morphic that runs inside the Morphic UI Process. A debugger written in Bloc will not work correctly with this UI Manager.

I handle exceptions in the Morphic UI process the same as ==MorphicUIManager==. However, I also have support for handling errors in the Bloc UI Process in spite of the fact that the actual debugger is only aware of a single UI process. I also do not require to override any methods from Pharo. My design could be improved by changing the way a ==DebugSession== handles the UI process.


"
Class {
	#name : #BlBlocMorphicUIManager,
	#superclass : #MorphicUIManager,
	#category : #'BlocHost-Morphic-Host'
}

{ #category : #actions }
BlBlocMorphicUIManager class >> useAsDefault [
	|uiManager|
	uiManager := self new.
	uiManager beDefault. 
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> blocUIProcess [
	" Answer the currently active UI process for bloc universe"

	^ BlUniverse default pulseLoop loopProcess
]

{ #category : #debug }
BlBlocMorphicUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
	"I open a debugger and add support for detecting also if the debugged process is the Bloc UI process.
	In that case I spawn another Bloc UI process instead of a Morphic one."

	| debugSession isForBlocUIProcess |

	debugSession := process newDebugSessionNamed: title startedAt: context.
	debugSession logStackToFileIfNeeded.
	
	isForBlocUIProcess := self isForBlockUIProcess: debugSession.
	isForBlocUIProcess "Handle the case of the Bloc UI process"
		ifTrue: [ debugSession errorWasInUIProcess: true ]. 
	debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
			isForBlocUIProcess "Handle the case of the Bloc UI process"
				ifTrue:[ self spawnNewBlocProcess ]
				ifFalse: [ self spawnNewMorphicProcess ]
			] ].
	
	"Perform the opening still through the Moprhic world, as this UI Manager should only be used with the Morphic debugger."
	self defer: [ 
		[ Smalltalk tools debugger 
			openOn: debugSession withFullView: bool andNotification: notificationString.
		] on: Error do: [ :ex | 	debugSession signalDebuggerError: ex ] ].
	
	process suspend.

]

{ #category : #debug }
BlBlocMorphicUIManager >> isForBlockUIProcess: debugSession [
	^ self blocUIProcess == debugSession interruptedProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeBlocUIProcess: aProcess [
	"Adopt aProcess as the UI process for Bloc -- probably because of proceeding from a debugger"
			
	BlUniverse default pulseLoop forceStartOfUIProcess: aProcess.
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeMorphicUIProcess: aProcess [
	"Adopt aProcess as the UI process for morphic -- probably because of proceeding from a debugger"
			
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeUIProcess: aProcess [
	| currentDebugSession |
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"
	
	"I explicitly check if the process corresponds to the Bloc UI process or not so I can determine which UI process to resume."
	aProcess name = BlUniverse default pulseLoop processId
		ifTrue:  [ 
			"The Bloc UI process needs to be handled in a special way. The current debugger only knows about the existance of a single UI process.
			Hence, on process the debugger tries to terminate the active UI process using ==Processor terminateActive== (DebugSession>>#terminate).
			While that works for the Morpic UI process, it will not work for the Bloc UI process, as the debugger for the Bloc UI process runs inside the Morphic UI process.
			
			Instead I do all the work of closing and resuming the correct Bloc UI process"
			BlUniverse default pulseLoop loopProcess terminate.
			self resumeBlocUIProcess: aProcess.
		
			"This is the only hack I found to make the debugger not terminate the current active process on close.
			In DebugSession>>#terminate the debugger terminates the activa process if the errorWasInUIProcess attribute is set to true.
			Here we set it to false to tell the debugger that the Bloc UI process is not the current UI process from the system."
			currentDebugSession := thisContext sender receiver. 
			currentDebugSession errorWasInUIProcess: false. ]
		ifFalse: [ 
			"Resume the Moprhic UI process normally as before"
			self resumeMorphicUIProcess: aProcess ]
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewBlocProcess [
	BlUniverse default pulseLoop forceStartNewUIProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewMorphicProcess [
	self spawnNewProcess
]
