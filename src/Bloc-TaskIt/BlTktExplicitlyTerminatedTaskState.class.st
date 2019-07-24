Class {
	#name : #BlTktExplicitlyTerminatedTaskState,
	#superclass : #BlTktCommandTaskState,
	#instVars : [
		'reason'
	],
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #testing }
BlTktExplicitlyTerminatedTaskState >> isFinished [
	^ true
]

{ #category : #accessing }
BlTktExplicitlyTerminatedTaskState >> reason [
	<return: #String>
	^ reason
]

{ #category : #accessing }
BlTktExplicitlyTerminatedTaskState >> reason: aString [
	self 
		assert: [ aString isNotNil ]
		description: [ 'Reason must be non-nil' ].
	reason := aString
]

{ #category : #signalling }
BlTktExplicitlyTerminatedTaskState >> signalExplicitlyTerminatedException [
	self error: 'Terminated by user'
]

{ #category : #'as yet unclassified' }
BlTktExplicitlyTerminatedTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState activeContext timeoutContext |

	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.
	
	activeContext := aTaskExecution executionProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	aTaskExecution executionProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason
]
