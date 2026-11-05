Class {
	#name : #BlSpaceDragWithElementEvent,
	#superclass : #BlSpaceDragWithDelegateEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSpaceDragWithElementEvent >> element [

	^ element
]

{ #category : #accessing }
BlSpaceDragWithElementEvent >> element: anObject [

	element := anObject
]
