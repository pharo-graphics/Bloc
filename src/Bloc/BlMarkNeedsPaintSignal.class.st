Class {
	#name : #BlMarkNeedsPaintSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #accessing }
BlMarkNeedsPaintSignal >> element [
	^ element
]

{ #category : #accessing }
BlMarkNeedsPaintSignal >> element: anObject [
	element := anObject
]
