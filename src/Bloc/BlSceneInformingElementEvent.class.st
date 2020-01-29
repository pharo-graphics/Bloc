Class {
	#name : #BlSceneInformingElementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSceneInformingElementEvent >> element [
	^ element
]

{ #category : #accessing }
BlSceneInformingElementEvent >> element: anObject [
	element := anObject
]
