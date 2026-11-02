Class {
	#name : #BlSpaceDragWithElementEvent,
	#superclass : #BlSpaceDragWithDelegateEvent,
	#instVars : [
		'element'
	],
	#category : #Bloc
}

{ #category : #accessing }
BlSpaceDragWithElementEvent >> element [

	^ element
]

{ #category : #accessing }
BlSpaceDragWithElementEvent >> element: anObject [

	element := anObject
]
