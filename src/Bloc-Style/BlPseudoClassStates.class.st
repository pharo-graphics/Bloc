Class {
	#name : #BlPseudoClassStates,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : 'Bloc-Style-Util'
}

{ #category : #'as yet unclassified' }
BlPseudoClassStates class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #accessing }
BlPseudoClassStates >> styleable [
	^ styleable
]

{ #category : #accessing }
BlPseudoClassStates >> styleable: anObject [
	styleable := anObject
]
