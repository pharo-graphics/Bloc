Class {
	#name : #BlSpaceDragWithDelegateEvent,
	#superclass : #BlSpaceDragEvent,
	#instVars : [
		'delegate'
	],
	#category : #Bloc
}

{ #category : #accessing }
BlSpaceDragWithDelegateEvent >> delegate [

	^ delegate
]

{ #category : #accessing }
BlSpaceDragWithDelegateEvent >> delegate: anObject [

	delegate := anObject
]
