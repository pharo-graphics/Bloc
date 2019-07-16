Class {
	#name : #BlTktUserCancelledTaskState,
	#superclass : #TKTTaskState,
	#instVars : [
		'reason'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #'instance-creation' }
BlTktUserCancelledTaskState class >> reason: aString [ 
	
	^ self new
		reason: aString;
		yourself
]

{ #category : #cancelling }
BlTktUserCancelledTaskState >> cancelTaskExecution: aTaskExecution reason: aReason [

	self error: 'Task already cancelled'
]

{ #category : #executing }
BlTktUserCancelledTaskState >> performTaskExecution: aTaskExecution [

	self signalCancelledException
]

{ #category : #accessing }
BlTktUserCancelledTaskState >> reason: aString [ 
	reason := aString
]

{ #category : #executing }
BlTktUserCancelledTaskState >> signalCancelledException [
	"Ignore at this moment. We might want to allow to debug or to resume
	See TKTRunningTaskState>>#userCancelTaskExecution:reason:"
	"TKTCancelledTaskException signal: reason"
]

{ #category : #cancelling }
BlTktUserCancelledTaskState >> userCancelTaskExecution: aTaskExecution reason: aReason [
	"Ignore as it is already canceled"
]
