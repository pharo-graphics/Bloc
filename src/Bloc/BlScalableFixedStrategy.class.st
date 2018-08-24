"
I allow users to set a custom zoom level of content element within scalable element
"
Class {
	#name : #BlScalableFixedStrategy,
	#superclass : #BlScalableStrategy,
	#instVars : [
		'zoom'
	],
	#category : 'Bloc-Utilities - Scalable'
}

{ #category : #'instance creation' }
BlScalableFixedStrategy class >> zoom: aNumber [
	^ self new zoom: aNumber
]

{ #category : #comparing }
BlScalableFixedStrategy >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ self zoom = anotherObject zoom
]

{ #category : #comparing }
BlScalableFixedStrategy >> hash [
	^ self class hash bitXor: self zoom hash
]

{ #category : #initialization }
BlScalableFixedStrategy >> initialize [
	super initialize.
	
	zoom := 1.0
]

{ #category : #testing }
BlScalableFixedStrategy >> isFixed [
	<return: #Boolean>
	
	^ true
]

{ #category : #scale }
BlScalableFixedStrategy >> scale: aContentElement within: aScalableElement [
	"Compute and return a scale factor of a content element within scalable element.
	Note: I am used during measurement pass, so you must only rely on measured bounds!"
	<return: #Number>
	
	^ self zoom
]

{ #category : #accessing }
BlScalableFixedStrategy >> zoom [
	<return: #Number>

	^ zoom
]

{ #category : #accessing }
BlScalableFixedStrategy >> zoom: aNumber [
	zoom := aNumber
]
