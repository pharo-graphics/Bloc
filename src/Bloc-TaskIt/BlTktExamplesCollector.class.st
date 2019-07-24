Class {
	#name : #BlTktExamplesCollector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'collection',
		'mutex'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #adding }
BlTktExamplesCollector >> add: anObject [
	mutex critical: [ collection add: anObject ]
]

{ #category : #accessing }
BlTktExamplesCollector >> collection [
	^ collection
]

{ #category : #accessing }
BlTktExamplesCollector >> increment [
	<return: #Integer>
	^ mutex critical: [ 
		| aNumber |
		aNumber := collection size + 1.
		collection add: aNumber.
		aNumber ]
]

{ #category : #initialization }
BlTktExamplesCollector >> initialize [
	super initialize.
	mutex := Mutex new.
	collection := OrderedCollection new.
]
