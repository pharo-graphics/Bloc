"
I am a special rope that is able to hold arbitrary items in a collection data structure.
My recommended maximum length (size) is defined in BrRope class>>#combineLength
"
Class {
	#name : #BlCollectionRope,
	#superclass : #BlRope,
	#instVars : [
		'collection'
	],
	#classInstVars : [
		'empty'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #cleanup }
BlCollectionRope class >> cleanUp [
	super cleanUp.
	
	empty := nil
]

{ #category : #'instance creation' }
BlCollectionRope class >> collection: aCollection [
	^ self new collection: aCollection
]

{ #category : #accessing }
BlCollectionRope class >> empty [
	"Return a unique empty collection rope which can be shared among all users"
	<return: #BlCollectionRope>
	
	^ empty ifNil: [ empty := self collection: #() ]
]

{ #category : #'instance creation' }
BlCollectionRope class >> from: aLeftRope and: aRightRope [
	| length array index |
	length := aLeftRope size + aRightRope size.
	array := Array new: length.
	index := 1.
	aLeftRope do: [ :item | array at: index put: item. index := index + 1 ].
	aRightRope do: [ :item | array at: index put: item. index := index + 1 ].
	^ self collection: array
]

{ #category : #'rope - accessing' }
BlCollectionRope >> at: anIndex [
	"Return an item at a given index"
	<return: #Object>

	^ collection at: anIndex
]

{ #category : #'rope - attributes' }
BlCollectionRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	| anAttributeRope |

	self assertAccessFrom: aStart to: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].
	
	"return an attributed rope of myself since we are empty"
	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self class attributeRope
		attributes: anAttributesCollection
		rope: self ].
	
	anAttributeRope := self class attributeRope
		attributes: anAttributesCollection
		rope: (self from: aStart to: anEnd).
	
	"attributes are applied on the whole rope, return it"
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].
		
	aStart = 1
		ifTrue: [ ^ anAttributeRope append: (self from: anEnd + 1 to: self size) ].
	
	anEnd = self size
		ifTrue: [ ^ (self from: 1 to: aStart - 1) append: anAttributeRope ].
	
	^  (self from: 1 to: aStart - 1) append: (anAttributeRope append: (self from: anEnd + 1 to: self size))
]

{ #category : #'rope - accessing' }
BlCollectionRope >> children [
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

{ #category : #'rope - deleting' }
BlCollectionRope >> delete: aStart to: anEnd [
	| newCollection |
	self assertAccessFrom: aStart to: anEnd.
	
	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self ].
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self empty ].
	
	newCollection := Array new: collection size - (anEnd - aStart + 1).
	
	aStart > 1 ifTrue: [ 
			newCollection
				replaceFrom: 1 to: aStart - 1
				with: collection
				startingAt: 1 ].
			
	anEnd < self size ifTrue: [ 
			newCollection
				replaceFrom: aStart to: newCollection size
				with: collection
				startingAt: anEnd + 1 ].
			
	^ self class collection: newCollection
]

{ #category : #'rope - accessing' }
BlCollectionRope >> depth [
	"Return the max tree height of this rope (composition depth).
	Collection rope is a leaf in a composition tree => depth is always 1"
	<return: #Number>

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
	
	^ self class empty
]

{ #category : #'rope - accessing' }
BlCollectionRope >> from: aStart to: anEnd [
	| aNewLegnth |
	self assertAccessFrom: aStart to: anEnd.

	(aStart isZero and: [ anEnd isZero ])
		ifTrue: [ ^ self empty ].

	"return this very rope if the requested sub-rope interval exactly matches myself"
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	aNewLegnth := anEnd - aStart + 1.

	^ (aNewLegnth <= self class combineLength)
		ifTrue: [ self class collection: (collection copyFrom: aStart to: anEnd) ]
		ifFalse: [ self class subRope rope: self offset: aStart - 1 length: aNewLegnth ]
]

{ #category : #'rope - enumeration' }
BlCollectionRope >> from: aStart to: anEnd do: aBlock [

	aStart
		to: anEnd
		by: (anEnd >= aStart ifTrue: [ 1 ] ifFalse: [ -1 ])
		do: [:index | aBlock value: (collection at: index) ]
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
		
	^ (self from: 1 to: anIndex) append: (anInsertionRope append: (self from: anIndex + 1 to: self size))
]

{ #category : #'rope - testing' }
BlCollectionRope >> isLeaf [
	"Collection rope can not contain other ropes (even if my collection consists of ropes,
	we don't count them and don't take into account such case)"
	<return: #Boolean>
	
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
		ifTrue: [ aCollection asArray , collection ]
		ifFalse: [ anIndex = self size
				ifTrue: [ collection , aCollection ]
				ifFalse: [ | tmpCollection |
					tmpCollection := Array new: collection size + aCollection size.
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
	leftArray := Array new: middle.
	rightArray := Array new: totalSize - middle.
	
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

{ #category : #'rope - accessing' }
BlCollectionRope >> size [
	"Return the amount of items in this rope, which is equal to the size of an underlying collection"
	<return: #Number>

	^ collection size
]
