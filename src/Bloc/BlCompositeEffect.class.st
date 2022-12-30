Class {
	#name : #BlCompositeEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'effects'
	],
	#category : #'Bloc-Effect'
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

{ #category : #initialization }
BlCompositeEffect >> initialize [
	super initialize.
	effects := OrderedCollection new
]
