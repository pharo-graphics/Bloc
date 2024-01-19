Extension { #name : 'Collection' }

{ #category : '*Bloc' }
Collection >> copyWithMergedAttributesWith: anotherCollectionOfAttributes [
	"Answer the merge of two collections of attributes, letting
	anotherCollectionOfAttributes to override attributes from self,
	based on its type"

	| anOrderedDictionary |
	anOrderedDictionary := OrderedDictionary new.

	self do: [ :each | 
		anOrderedDictionary at: each ropeAttributeType put: each ].
	anotherCollectionOfAttributes do: [ :each | 
		anOrderedDictionary at: each ropeAttributeType put: each ].

	^ anOrderedDictionary values
]

{ #category : '*Bloc' }
Collection >> copyWithoutDuplicatedRopeAttributes [
	"Answer a collection without duplicates from a given collection, preserving the original order"

	| anOrderedDictionary |
	self size = 1 ifTrue: [ ^ self copy ].

	anOrderedDictionary := OrderedDictionary new.
	self do: [ :each | 
		anOrderedDictionary at: each ropeAttributeType put: each ].
	
	^ anOrderedDictionary values
]
