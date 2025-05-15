Class {
	#name : #BlGridPackedMap,
	#superclass : #Object,
	#instVars : [
		'values',
		'indices',
		'keys'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'instance creation' }
BlGridPackedMap class >> fromAssociations: anArrayOfAssociations [

	^ self basicNew
		initializeWithAssociations: anArrayOfAssociations;
		yourself
]

{ #category : #accessing }
BlGridPackedMap >> at: index [

	^ values at: (indices at: index)
]

{ #category : #accessing }
BlGridPackedMap >> initializeWithAssociations: associations [

	| keyToIndex |
	keyToIndex := Dictionary new.

	"Initialize indices"
	indices := Array new: associations size withAll: 0.
	1 to: associations size do: [ :i |
		| key index |
		key := (associations at: i) key.
		index := keyToIndex at: key ifAbsentPut: [ keyToIndex size + 1 ].
		indices at: i put: index ].

	"Initialize keys and values"
	keys := Array new: keyToIndex size.
	values := Array new: keyToIndex size.
	1 to: associations size do: [ :i |
		keys at: (indices at: i) put: (associations at: i) key.
		values at: (indices at: i) put: (associations at: i) value ]
]

{ #category : #accessing }
BlGridPackedMap >> keys [

	^ keys
]

{ #category : #accessing }
BlGridPackedMap >> keysAndValuesDo: aBlock [

	1 to: self keys size do: [ :i |
		aBlock value: (self keys at: i) value: (self values at: i) ]
]

{ #category : #accessing }
BlGridPackedMap >> keysDo: aBlock [

	keys do: aBlock
]

{ #category : #accessing }
BlGridPackedMap >> values [

	^ values
]

{ #category : #accessing }
BlGridPackedMap >> valuesDo: aBlock [

	values do: aBlock
]
