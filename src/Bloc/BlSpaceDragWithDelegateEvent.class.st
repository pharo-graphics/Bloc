Class {
	#name : #BlSpaceDragWithDelegateEvent,
	#superclass : #BlSpaceDragEvent,
	#instVars : [
		'delegate'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSpaceDragWithDelegateEvent >> delegate [

	^ delegate
]

{ #category : #accessing }
BlSpaceDragWithDelegateEvent >> delegate: anObject [

	delegate := anObject
]
