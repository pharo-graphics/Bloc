"
BlTaskAtErrorSignal is used when BlTaskAtQueue encounters an error during execution.

- If the error occurs while evaluating a task the task is set.
- In all cases a message and the exception is set.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	exception:		<Error>	the exception encountered during execution
	message:			<String>	a message about where the error was encountered
	task:				<Object>	the task being evaluated when the error was encountered

"
Class {
	#name : #BlTaskAtErrorSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'exception',
		'message',
		'task'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlTaskAtErrorSignal >> exception [
	^ exception
]

{ #category : #accessing }
BlTaskAtErrorSignal >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
BlTaskAtErrorSignal >> message [
	^ message
]

{ #category : #accessing }
BlTaskAtErrorSignal >> message: anObject [
	message := anObject
]

{ #category : #accessing }
BlTaskAtErrorSignal >> task [
	^ task
]

{ #category : #accessing }
BlTaskAtErrorSignal >> task: anObject [
	task := anObject
]
