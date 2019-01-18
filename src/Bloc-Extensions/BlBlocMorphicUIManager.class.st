"
I a temporary solution for handling the opening of the debugger when errors happen in the Bloc UI thread.

I do that by explicitly spawning either a Bloc or a Morphic UI thread depending on where the error occured.
"
Class {
	#name : #BlBlocMorphicUIManager,
	#superclass : #MorphicUIManager,
	#category : #'Bloc-Extensions'
}

{ #category : #actions }
BlBlocMorphicUIManager class >> useAsDefault [
	[
		|uiManager|
		uiManager := self new.
		uiManager uiProcess ifNotNil: [ 
			uiManager terminateUIProcess.
			uiManager spawnNewProcess ].
		uiManager beDefault.
	] fork.
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> blocUIProcess [
	" Answer the currently active UI process for bloc universe"

	^ BlUniverse default pulseLoop loopProcess
]

{ #category : #debug }
BlBlocMorphicUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
	"Open a notifier in response to an error, halt, or notify. A notifier view
	just shows a short view of the sender stack and provides a menu that
	lets the user open a full debugger."

	| debugSession isForBlocUIProcess |

	debugSession := process newDebugSessionNamed: title startedAt: context.
	debugSession logStackToFileIfNeeded.
	
	isForBlocUIProcess := self isForBlockUIProcess: debugSession.
	isForBlocUIProcess "Handle the case of the bloc ui thread"
		ifTrue: [ debugSession errorWasInUIProcess: true ]. 
	debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
			isForBlocUIProcess "Handle the case of the bloc ui thread"
				ifTrue:[ self spawnNewBlocProcess ]
				ifFalse: [ self spawnNewMorphicProcess ]
			] ].
	
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
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"
			
	BlUniverse default pulseLoop forceStartOfUIProcess: aProcess.
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeMorphicUIProcess: aProcess [
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"
			
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> resumeUIProcess: aProcess [
	| currentDebugSession |
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"
	
	aProcess name = BlUniverse default pulseLoop processId
		ifTrue:  [ 
			BlUniverse default pulseLoop loopProcess terminate.
			self resumeBlocUIProcess: aProcess.
			
			currentDebugSession := thisContext sender receiver. 
			currentDebugSession errorWasInUIProcess: false. ]
		ifFalse: [ 
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
