Class {
	#name : 'BlTextAttributesExplicitFinder',
	#superclass : 'Object',
	#traits : 'TBlTextAttributesFinder',
	#classTraits : 'TBlTextAttributesFinder classTrait',
	#instVars : [
		'attributes',
		'interval'
	],
	#package : 'Bloc',
	#tag : 'Text-Text-Attributes Finder',
	#package : 'Bloc-Text',
	#tag : 'Text-Attributes Finder'
}

{ #category : 'enumerating' }
BlTextAttributesExplicitFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [	
	(attributes includes: aBlTextAttribute)
		ifFalse: [ ^ self ].
		
	aBlock
		cull: interval first
		cull: interval last
		cull: aBlTextAttribute
]

{ #category : 'enumerating' }
BlTextAttributesExplicitFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	attributes select: aFilterBlock thenDo: [ :eachAttribute |
		anIterationBlock
			cull: interval first
			cull: interval last
			cull: eachAttribute ]
]

{ #category : 'initialization' }
BlTextAttributesExplicitFinder >> initializeForAttributes: aCollectionOfAttributes interval: anInterval [
	attributes := aCollectionOfAttributes asSet.
	interval := anInterval
]
