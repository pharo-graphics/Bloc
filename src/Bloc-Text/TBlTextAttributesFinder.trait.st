Trait {
	#name : 'TBlTextAttributesFinder',
	#category : 'Bloc-Text-Text-Attributes Finder'
}

{ #category : 'enumerating' }
TBlTextAttributesFinder >> attributesAndIndicesDo: aBlock [
	self
		findAttributesSuchThat: [ :eachAttribute | true ]
		indicesDo: aBlock
]

{ #category : 'enumerating' }
TBlTextAttributesFinder >> attributesAndIndicesSuchThat: aFilterBlock [
	^ Array streamContents: [ :aStream | 
		  self
			  findAttributesSuchThat: aFilterBlock
			  indicesDo: [ :aStart :anEnd :anAttribute | 
				  aStream nextPut: anAttribute -> (aStart to: anEnd) ] ]
]

{ #category : 'private' }
TBlTextAttributesFinder >> computeAttributesDictionaryFor: aBlText [
	| anIterator theAttributes |

	theAttributes := OrderedDictionary new.
	anIterator := aBlText iterator.

	[ anIterator hasNext ] whileTrue: [
		anIterator attributes
			do: [ :eachAttribute |
				theAttributes
					at: eachAttribute
					ifPresent: [ :aCollectionOfIntervals |
						(aCollectionOfIntervals last last = anIterator position)
							ifTrue: [ aCollectionOfIntervals last at: 2 put: anIterator position + 1 ]
							ifFalse: [ aCollectionOfIntervals add: (OrderedCollection
								with: anIterator position + 1
								with: anIterator position + 1) ] ]
					ifAbsentPut: [
						OrderedCollection with:
							(OrderedCollection
								with: anIterator position + 1
								with: anIterator position + 1) ] ].
		anIterator next ].
	
	^ theAttributes
]

{ #category : 'enumerating' }
TBlTextAttributesFinder >> findAttribute: aBlTextAttribute indicesDo: aBlock [	
	self explicitRequirement
]

{ #category : 'enumerating' }
TBlTextAttributesFinder >> findAttributes: aCollectionOfBlTextAttribute indicesDo: aBlock [	
	
	aCollectionOfBlTextAttribute do: [ :eachAttribute |
		self
			findAttribute: eachAttribute
			indicesDo: aBlock	]
]

{ #category : 'enumerating' }
TBlTextAttributesFinder >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [
	self explicitRequirement
]

{ #category : 'testing' }
TBlTextAttributesFinder >> hasAttribute: aBlTextAttribute [
	<return: #Boolean>

	self
		findAttribute: aBlTextAttribute
		indicesDo: [ :aStart :anEnd | ^ true ].

	^ false
]

{ #category : 'testing' }
TBlTextAttributesFinder >> hasAttributeSuchThat: aComparisonBlock [
	<return: #Boolean>

	self
		findAttributesSuchThat: aComparisonBlock
		indicesDo: [ :aStart :anEnd | ^ true ].
		
	^ false
]
