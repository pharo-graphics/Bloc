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

{ #category : #'as yet unclassified' }
BlCompositeEffect >> applyEffectOnSpartaCanvas: aSpartaCanvas for: anElement around: aBlock [
	self applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement.
	effects
		do: [ :e | 
			e
				applyEffectOnSpartaCanvas: aSpartaCanvas
				for: anElement
				around: aBlock ].
	self applyAfterOnSpartaCanvas: aSpartaCanvas for: anElement
]

{ #category : #initialization }
BlCompositeEffect >> initialize [
	super initialize.
	effects := OrderedCollection new
]
