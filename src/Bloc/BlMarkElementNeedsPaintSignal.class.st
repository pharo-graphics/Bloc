Class {
	#name : 'BlMarkElementNeedsPaintSignal',
	#superclass : 'ContextStackSignal',
	#instVars : [
		'element'
	],
	#category : 'Bloc-Space - Support'
}

{ #category : 'accessing' }
BlMarkElementNeedsPaintSignal >> element [
	^ element
]

{ #category : 'accessing' }
BlMarkElementNeedsPaintSignal >> element: anObject [
	element := anObject
]
