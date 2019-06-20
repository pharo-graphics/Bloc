Class {
	#name : #BlElementChangeRecord,
	#superclass : #Object,
	#instVars : [
		'changedValue',
		'wasNotified'
	],
	#category : #'Bloc-Basic-Changes'
}

{ #category : #accessing }
BlElementChangeRecord >> beNotified [
	wasNotified := true
]

{ #category : #accessing }
BlElementChangeRecord >> changedValue [
	^ changedValue
]

{ #category : #accessing }
BlElementChangeRecord >> changedValue: anObject [
	changedValue := anObject
]

{ #category : #printing }
BlElementChangeRecord >> gtDisplayOn: aStream [
	self changedValue gtDisplayOn: aStream
]

{ #category : #initialization }
BlElementChangeRecord >> initialize [
	super initialize.
	
	wasNotified := false
]

{ #category : #printing }
BlElementChangeRecord >> printOn: aStream [
	
	self changedValue printOn: aStream.
	
	self wasNotified
		ifTrue: [ aStream nextPutAll: ' => Notified' ].
]

{ #category : #accessing }
BlElementChangeRecord >> seamlessDefaultTransferStrategy [ 
	^SeamlessTransferStrategy defaultByValue
]

{ #category : #testing }
BlElementChangeRecord >> wasNotified [
	<return: #Boolean>

	^ wasNotified
]
