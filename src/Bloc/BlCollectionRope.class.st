"
I am a special rope that is able to hold arbitrary items in a collection data structure.
My recommended maximum length (size) is defined in `BlRope class>>#combineLength`

"
Class {
	#name : #BlCollectionRope,
	#superclass : #BlRope,
	#instVars : [
		'collection'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'instance creation' }
BlCollectionRope class >> collection: aCollection [

	^ self new
		  collection: aCollection;
		  yourself
]

{ #category : #'instance creation' }
BlCollectionRope class >> from: leftCollectionRope and: rightCollectionRope [

	| aNewSpecies |
	aNewSpecies :=
		leftCollectionRope collection species =  rightCollectionRope collection species
			ifTrue: [ leftCollectionRope collection species ]
			ifFalse: [ Array ].
	
	^ self collection: (aNewSpecies streamContents: [ :aStream |
		leftCollectionRope do: [ :eachItem | aStream nextPut: eachItem ].
		rightCollectionRope do: [ :eachItem | aStream nextPut: eachItem ] ])
]

{ #category : #'rope - accessing' }
BlCollectionRope >> at: anIndex [
	"Return an item at a given index"
	<return: #Object>

	^ collection at: anIndex
]

{ #category : #'rope - attributes' }
BlCollectionRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	"See BlRope>>#attributes:from:to: for the detailed explanation on start and end indices"
	<return: #BlRope>
	| anAttributeRope |

	self assertAccessFrom: aStart to: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].

	anAttributeRope := self class attributeRope
		attributes: anAttributesCollection
		rope: (self from: aStart to: anEnd).

	"attributes are applied on the whole rope, return it"
	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].

	aStart = 0
		ifTrue: [ ^ anAttributeRope append: (self from: anEnd to: self size) ].

	anEnd = self size
		ifTrue: [ ^ (self from: 0 to: aStart) append: anAttributeRope ].

	^  (self from: 0 to: aStart) append: (anAttributeRope append: (self from: anEnd to: self size))
]

{ #category : #'rope - accessing' }
BlCollectionRope >> children [
	<return: #Collection of: #BlRope>

	^ { }
]

{ #category : #'rope - attributes' }
BlCollectionRope >> clearAttributes: aStart to: anEnd if: aBlock [
	^ self
]

{ #category : #accessing }
BlCollectionRope >> collection [
	"Return a collection behind this rope"
	<return: #SequenceableCollection of: #Object>

	^ collection
]

{ #category : #initialization }
BlCollectionRope >> collection: aCollection [
	collection := aCollection
]

{ #category : #private }
BlCollectionRope >> copyFrom: aStart to: anEnd [
	self assertAccessFrom: aStart to: anEnd.

	"return this very rope if the requested interval exactly matches myself"
	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self class collection: (collection copyFrom: aStart + 1 to: anEnd)
]

{ #category : #'rope - deleting' }
BlCollectionRope >> delete: aStart to: anEnd [
	<return: #BlRope>
	| newCollection |

	self assertAccessFrom: aStart to: anEnd.
	
	aStart = anEnd
		ifTrue: [ ^ self ].
	
	"deleting from a long collection is not efficient, so we will use subropes instead"
	self size >= self class combineLength
		ifTrue: [
			^ aStart isZero
				ifTrue: [
					anEnd = self size
						ifTrue: [ self empty ]
						ifFalse: [ self from: anEnd to: self size ] ]
				ifFalse: [
					| aLeftPart |
					aLeftPart := self from: 0 to: aStart.
					anEnd = self size
						ifTrue: [ aLeftPart ]
						ifFalse: [ aLeftPart append: (self from: anEnd to: self size) ] ] ].

	newCollection := collection species new: collection size - (anEnd - aStart).

	newCollection
		replaceFrom: 1 to: aStart
		with: collection
		startingAt: 1.

	newCollection
		replaceFrom: aStart + 1 to: newCollection size
		with: collection
		startingAt: anEnd + 1.

	^ self class collection: newCollection
]

{ #category : #'rope - accessing' }
BlCollectionRope >> depth [
	"Return the max tree height of this rope (composition depth).
	Collection rope is a leaf in a composition tree => depth is always 1"

	^ 1
]

{ #category : #'rope - enumeration' }
BlCollectionRope >> do: aBlock [
	collection do: aBlock
]

{ #category : #'rope - accessing' }
BlCollectionRope >> empty [
	"Return an empty collection rope"
	<return: #BlRope>

	^ self class collection: (collection species new: 0)
]

{ #category : #'rope - accessing' }
BlCollectionRope >> from: aStart to: anEnd [
	| aNewLegnth |
	self assertAccessFrom: aStart to: anEnd.

	"return this very rope if the requested sub-rope interval exactly matches myself"
	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	aNewLegnth := anEnd - aStart.

	^ (aNewLegnth <= self class combineLength and: [ self size <= self class combineLength ])
		ifTrue: [ self class collection: (collection copyFrom: aStart + 1 to: anEnd) ]
		ifFalse: [ self class subRope rope: self offset: aStart length: aNewLegnth ]
]

{ #category : #'rope - enumeration' }
BlCollectionRope >> from: aStart to: anEnd do: aBlock [

	aStart + 1
		to: anEnd
		by: (anEnd >= aStart ifTrue: [ 1 ] ifFalse: [ -1 ])
		do: [ :anIndex | aBlock value: (collection at: anIndex) ]
]

{ #category : #'rope - inserting' }
BlCollectionRope >> insertItems: aCollection at: anIndex [
	| anInsertionRope |

	self assertIndexForInsert: anIndex.

	"new collection is smaller than combine length, let's merge them"
	self size + aCollection size <= self class combineLength
		ifTrue: [ ^ self merge: aCollection at: anIndex ].

	self size + aCollection size <= (self class combineLength * 2)
		ifTrue: [ ^ self mergeSplit: aCollection at: anIndex ].
	
	anInsertionRope := self class collectionRope collection: aCollection.
	
	anIndex = 0
		ifTrue: [ ^ anInsertionRope append: self ].
		
	anIndex = self size
		ifTrue: [ ^ self append: anInsertionRope ].
		
	^ (self from: 0 to: anIndex) append: (anInsertionRope append: (self from: anIndex to: self size))
]

{ #category : #'rope - testing' }
BlCollectionRope >> isLeaf [
	"Collection rope can not contain other ropes (even if my collection consists of ropes,
	we don't count them and don't take into account such case)"
	
	^ true
]

{ #category : #'rope - enumeration' }
BlCollectionRope >> iterator: aStart to: anEnd [
	^ BlCollectionRopeIterator rope: self from: aStart to: anEnd
]

{ #category : #private }
BlCollectionRope >> merge: aCollection at: anIndex [
	| newCollection |
	newCollection := anIndex = 0
		ifTrue: [ aCollection species = collection species
			ifTrue: [ aCollection, collection ]
			ifFalse: [ aCollection, (collection as: aCollection species) ] ]
		ifFalse: [ anIndex = self size
				ifTrue: [ (collection as: aCollection species) , aCollection ]
				ifFalse: [ | tmpCollection |
					tmpCollection := aCollection species new: collection size + aCollection size.
					tmpCollection
						replaceFrom: 1
						to: anIndex
						with: collection
						startingAt: 1.
					tmpCollection
						replaceFrom: anIndex + 1
						to: anIndex + aCollection size
						with: aCollection
						startingAt: 1.
					tmpCollection
						replaceFrom: anIndex + aCollection size + 1
						to: tmpCollection size
						with: collection
						startingAt: anIndex + 1.
					tmpCollection ] ].
	^ self class collectionRope collection: newCollection
]

{ #category : #private }
BlCollectionRope >> mergeSplit: aCollection at: anIndex [
	| leftArray rightArray middle totalSize leftAmountBeforeIndex leftAmountFromCollection leftAmountAfterIndex rightAmountBeforeIndex alreadyFilledAmount alreadyFilledAmountFromCollection rightAmountFromCollection rightAmountAfterIndex |
	
	totalSize := collection size + aCollection size.
	middle := (totalSize / 2) asInteger.
	leftArray := collection species new: middle.
	rightArray := collection species new: totalSize - middle.
	
	leftAmountBeforeIndex := (middle min: anIndex) max: 0.
	alreadyFilledAmount := leftAmountBeforeIndex.
	leftAmountBeforeIndex > 0
		ifTrue: [ 
			leftArray
				replaceFrom: 1
				to: leftAmountBeforeIndex
				with: collection
				startingAt: 1  ].

	leftAmountFromCollection := ((middle - leftAmountBeforeIndex) min: aCollection size) max: 0.
	alreadyFilledAmountFromCollection := leftAmountFromCollection.
	leftAmountFromCollection > 0
		ifTrue: [
			leftArray
				replaceFrom: leftAmountBeforeIndex + 1
				to: leftAmountBeforeIndex + leftAmountFromCollection
				with: aCollection
				startingAt: 1 ].
	
	leftAmountAfterIndex := (middle - leftAmountBeforeIndex - leftAmountFromCollection) max: 0.
	alreadyFilledAmount := alreadyFilledAmount + leftAmountAfterIndex.
	"it is greater than zero if we can still fill left part"
	leftAmountAfterIndex > 0
		ifTrue: [ 
			leftArray
				replaceFrom: leftArray size - leftAmountAfterIndex + 1
				to: leftArray size
				with: collection
				startingAt: leftAmountBeforeIndex + 1 ].

	rightAmountBeforeIndex := (anIndex - middle) max: 0.
	rightAmountBeforeIndex > 0
		ifTrue: [ 
			rightArray
				replaceFrom: 1
				to: rightAmountBeforeIndex
				with: collection
				startingAt: alreadyFilledAmount + 1 ].
	alreadyFilledAmount := alreadyFilledAmount + rightAmountBeforeIndex.
	
	rightAmountFromCollection := (aCollection size - alreadyFilledAmountFromCollection) max: 0.
	rightAmountFromCollection > 0
		ifTrue: [
			rightArray
				replaceFrom: rightAmountBeforeIndex + 1
				to: rightAmountBeforeIndex + rightAmountFromCollection
				with: aCollection
				startingAt: alreadyFilledAmountFromCollection + 1 ].
	
	rightAmountAfterIndex := (collection size - alreadyFilledAmount) max: 0.
	rightAmountAfterIndex > 0
		ifTrue: [ 
			rightArray
				replaceFrom: rightArray size - rightAmountAfterIndex + 1
				to: rightArray size
				with: collection
				startingAt: collection size - rightAmountAfterIndex + 1 ].
	
	^ self class
		concatenate: (self class collectionRope collection: leftArray)
		and: (self class collectionRope collection: rightArray)
]

{ #category : #accessing }
BlCollectionRope >> readStream [ 
	"Answer a read stream that iterates over the characters in the receiver's collection"

	^ collection readStream
]

{ #category : #'rope - replacing' }
BlCollectionRope >> simplified [
	<return: #BlRope>
	
	^ self
]

{ #category : #'rope - accessing' }
BlCollectionRope >> size [
	"Return the amount of items in this rope, which is equal to the size of an underlying collection"
	<return: #Number>

	^ collection size
]
