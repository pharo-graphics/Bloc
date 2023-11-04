"
#Text attributes cache
{{gtClass:BlText}} allows users to assign attributes on a text interval. In addition, it is important to to be able to query text attributes efficiently. The attributes cache is responsible for maintaining an association cache between text attributes and their corresponding interval in the text.
"
Class {
	#name : #BlTextAttributesCachingFinder,
	#superclass : #Object,
	#traits : 'TBlTextAttributesFinder',
	#classTraits : 'TBlTextAttributesFinder classTrait',
	#instVars : [
		'attributes'
	],
	#category : #'Bloc-Text-Text-Attributes Finder'
}

{ #category : #enumerating }
BlTextAttributesCachingFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [	
	attributes
		at: aBlTextAttribute
		ifPresent: [ :aCollectionOfIntervals |
			aCollectionOfIntervals do: [ :eachInterval |
				aBlock
					cull: eachInterval first
					cull: eachInterval last
					cull: aBlTextAttribute ] ]
]

{ #category : #enumerating }
BlTextAttributesCachingFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	attributes keysAndValuesDo: [ :eachAttribute :aCollectionOfIntervals |
		(aFilterBlock value: eachAttribute)
			ifTrue: [
				aCollectionOfIntervals do: [ :eachInterval |
					anIterationBlock
						cull: eachInterval first
						cull: eachInterval last
						cull: eachAttribute ] ] ]
]

{ #category : #initialization }
BlTextAttributesCachingFinder >> initializeForText: aBlText [
	attributes := self computeAttributesDictionaryFor: aBlText
]
