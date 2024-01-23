Class {
	#name : #BlCompositeEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'effects'
	],
	#category : 'Bloc-Effect'
}

{ #category : #'as yet unclassified' }
BlCompositeEffect class >> effects: aCollection [
	^ self new
		addAll: aCollection;
		yourself
]

{ #category : #adding }
BlCompositeEffect >> addAll: aCollection [
	effects addAll: aCollection
]

{ #category : #geometry }
BlCompositeEffect >> computeBounds: aBlBounds [

	effects do: [ :each | each computeBounds: aBlBounds ].
	^ aBlBounds
]

{ #category : #initialization }
BlCompositeEffect >> initialize [

	super initialize.
	effects := OrderedCollection new
]

{ #category : #testing }
BlCompositeEffect >> wantsCompositionLayer [

	^ effects anySatisfy: [ :each | each wantsCompositionLayer ]
]
