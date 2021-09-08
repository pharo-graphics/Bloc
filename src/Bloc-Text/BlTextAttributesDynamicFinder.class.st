Class {
	#name : 'BlTextAttributesDynamicFinder',
	#superclass : 'Object',
	#traits : 'TBlTextAttributesFinder',
	#classTraits : 'TBlTextAttributesFinder classTrait',
	#instVars : [
		'text'
	],
	#category : 'Bloc-Text-Text-Attributes Finder'
}

{ #category : 'enumerating' }
BlTextAttributesDynamicFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [	
	| theAttributes |

	theAttributes := self computeAttributesDictionaryFor: text.
	theAttributes
		at: aBlTextAttribute
		ifPresent: [ :aCollectionOfIntervals |
			aCollectionOfIntervals do: [ :eachInterval |
				aBlock
					cull: eachInterval first
					cull: eachInterval last
					cull: aBlTextAttribute ] ]
]

{ #category : 'enumerating' }
BlTextAttributesDynamicFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	| theAttributes |

	theAttributes := self computeAttributesDictionaryFor: text.
	theAttributes keysAndValuesDo: [ :eachAttribute :aCollectionOfIntervals |
		(aFilterBlock value: eachAttribute)
			ifTrue: [
				aCollectionOfIntervals do: [ :eachInterval |
					anIterationBlock
						cull: eachInterval first
						cull: eachInterval last
						cull: eachAttribute ] ] ]
]

{ #category : 'initialization' }
BlTextAttributesDynamicFinder >> initializeForText: aBlText [
	text := aBlText
]
