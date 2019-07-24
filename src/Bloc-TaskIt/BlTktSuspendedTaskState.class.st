Class {
	#name : #BlTktSuspendedTaskState,
	#superclass : #TKTTaskState,
	#instVars : [
		'reason'
	],
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #'instance-creation' }
BlTktSuspendedTaskState class >> reason: aString [ 
	
	^ self new
		reason: aString;
		yourself
]

{ #category : #cancelling }
BlTktSuspendedTaskState >> cancelTaskExecution: aTaskExecution reason: aReason [

	self error: 'Task already cancelled by user'
]

{ #category : #executing }
BlTktSuspendedTaskState >> performTaskExecution: aTaskExecution [

	self signalCancelledException
]

{ #category : #accessing }
BlTktSuspendedTaskState >> reason: aString [ 
	reason := aString
]

{ #category : #executing }
BlTktSuspendedTaskState >> signalCancelledException [
	"Ignore at this moment. We might want to allow to debug or to resume
	See TKTRunningTaskState>>#userCancelTaskExecution:reason:"
	"TKTCancelledTaskException signal: reason"
	self error: 'Should not receive this message'
]

{ #category : #executing }
BlTktSuspendedTaskState >> signalSuspendedException [
	"Ignore at this moment. We might want to allow to debug or to resume
	See TKTRunningTaskState>>#userCancelTaskExecution:reason:"
	"TKTCancelledTaskException signal: reason"
	self error: 'Should not receive this message'
]
