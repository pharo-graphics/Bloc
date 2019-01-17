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
		uiManager := BlBlocMorphicUIManager new.
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

	| debugSession |

	debugSession := process newDebugSessionNamed: title startedAt: context.
	debugSession logStackToFileIfNeeded.
	
	(self isForBlockUIProcess: debugSession) "Handle the case of the bloc ui thread"
		ifTrue: [ debugSession errorWasInUIProcess: true ]. 
	debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
			(self isForBlockUIProcess: debugSession) "Handle the case of the bloc ui thread"
				ifTrue:[ self spawnNewBlocProcess ]
				ifFalse: [ self spawnNewMorphicProcess ]
			]].
		
	self defer:	[ 
			"schedule debugger in deferred UI message to address
			redraw problems after opening a debugger e.g. from
			the testrunner."
		[ Smalltalk tools debugger 
				openOn: debugSession withFullView: bool andNotification: notificationString.
		] on: Error do: [ :ex | 	debugSession signalDebuggerError: ex] 
	].

	process suspend.

]

{ #category : #debug }
BlBlocMorphicUIManager >> isForBlockUIProcess: debugSession [
	^ self blocUIProcess == debugSession interruptedProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewBlocProcess [
	BlUniverse default pulseLoop forceStartNewUIProcess
]

{ #category : #'ui process' }
BlBlocMorphicUIManager >> spawnNewMorphicProcess [
	self spawnNewProcess
]
