"
I am a special type of rope that can contain a set of attributes.
I am able to add attributes to any type of rope by decorating it with attribute rope, it means that I am not a leaf rope

"
Class {
	#name : #BlAttributeRope,
	#superclass : #BlRope,
	#instVars : [
		'attributes',
		'rope'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #initialization }
BlAttributeRope class >> attributes: anAttributeCollection rope: aRope [

	| aMergedCollection aMergedRope |
	
	aMergedCollection := aRope isAttributed
		ifTrue: [ aRope attributes
			copyWithMergedAttributesWith: anAttributeCollection ]
		ifFalse: [ anAttributeCollection ].
		
	aMergedRope := aRope isAttributed
		ifTrue: [ aRope rope ]
		ifFalse: [ aRope ].

	^ self new
		attributes: aMergedCollection rope: aMergedRope;
		yourself
]

{ #category : #utilities }
BlAttributeRope class >> combineAttributed: aLeftAttributeRope and: aRightAttributeRope [

	^ self
		attributes: aLeftAttributeRope attributes
		rope: (self concatenate: aLeftAttributeRope rope and: aRightAttributeRope rope)
]

{ #category : #utility }
BlAttributeRope class >> mergeAttributes: aCollectionOfAttributes and: anotherCollectionOfAttributes [
	"Merge two collection of attributes letting anotherCollectionOfAttributes to override
	attributes from aCollectionOfAttributes based on its type"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	((aCollectionOfAttributes isKindOf: HashedCollection) or: [ anotherCollectionOfAttributes isKindOf: HashedCollection ])
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.

	aCollectionOfAttributes do: [ :each | anOrderedDictionary at: (self typeOf: each) put: each ].
	anotherCollectionOfAttributes do: [ :each | anOrderedDictionary at: (self typeOf: each) put: each ].

	^ anOrderedDictionary values
]

{ #category : #utility }
BlAttributeRope class >> typeOf: anObject [

	^[anObject type] onErrorDo: [:ex | anObject]
	
]

{ #category : #'rope - accessing' }
BlAttributeRope >> at: anIndex [
	^ rope at: anIndex
]

{ #category : #accessing }
BlAttributeRope >> attributes [
	<return: #Collection of: #Object>

	^ attributes
]

{ #category : #'rope - attributes' }
BlAttributeRope >> attributes: anAttributesCollection from: aStart to: anEnd [

	| anAttributeRope |
	self assertAccessFrom: aStart to: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].
	
	anAttributeRope := (self rope from: aStart to: anEnd)
		attributes: (self attributes
			copyWithMergedAttributesWith: anAttributesCollection)
		from: 0
		to: (anEnd - aStart).

	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].

	aStart = 0 ifTrue: [ 
		^ self class
			concatenate: anAttributeRope
			and: (self from: anEnd to: self size) ].
	
	anEnd = self size ifTrue: [ 
		^ self class
			concatenate: (self from: 0 to: aStart)
			and: anAttributeRope ].

	^ (self from: 0 to: aStart)
		append: (anAttributeRope
			append: (self from: anEnd to: self size))
]

{ #category : #initialization }
BlAttributeRope >> attributes: theAttributes rope: aRope [

	attributes := theAttributes copyWithoutDuplicatedRopeAttributes.
	rope := aRope
]

{ #category : #'rope - accessing' }
BlAttributeRope >> children [
	^ { rope }
]

{ #category : #'rope - attributes' }
BlAttributeRope >> clearAttributes: aStart to: anEnd if: aBlock [
	| aSubRope aClearedRope preservedAttributes anyAttributeRemoved |
	self assertAccessFrom: aStart to: anEnd.
	
	preservedAttributes := self attributes reject: [ :anAssociation | aBlock value: anAssociation value ].
	anyAttributeRemoved := preservedAttributes size ~= self attributes size.
	
	aSubRope := self rope from: aStart to: anEnd.
	
	aClearedRope := aSubRope
		clearAttributes: 0
		to: aSubRope size
		if: aBlock.

	anyAttributeRemoved := anyAttributeRemoved or: [ aSubRope ~= aClearedRope ].
	anyAttributeRemoved
		ifFalse: [ ^ self ].

	preservedAttributes ifNotEmpty: [ :theAttributes | aClearedRope := aClearedRope attributes: theAttributes ].

	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ aClearedRope ].

	aStart = 0 ifTrue: [ 
		^ self class
			concatenate: aClearedRope
			and: (self from: anEnd to: self size) ].
	
	anEnd = self size ifTrue: [ 
		^ self class
			concatenate: (self from: 0 to: aStart)
			and: aClearedRope ].

	^ (self from: 0 to: aStart) append: (aClearedRope append: (self from: anEnd to: self size))
]

{ #category : #'rope - deleting' }
BlAttributeRope >> delete: aStart to: anEnd [
	<return: #BlRope>
	self assertAccessFrom: aStart to: anEnd.

	aStart = anEnd
		ifTrue: [ ^ self ].

	^ self class attributeRope
		attributes: attributes
		rope: (rope delete: aStart to: anEnd)
]

{ #category : #'rope - accessing' }
BlAttributeRope >> depth [
	^ rope depth
]

{ #category : #'rope - enumeration' }
BlAttributeRope >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'rope - accessing' }
BlAttributeRope >> empty [
	"Create and return an empty version of this rope"
	<return: #BlRope>
	
	^ self class
		attributes: self attributes
		rope: self rope empty
]

{ #category : #'rope - accessing' }
BlAttributeRope >> from: aStart to: anEnd [
	<return: #BlRope>

	self assertAccessFrom: aStart to: anEnd.

	(aStart = anEnd)
		ifTrue: [ ^ self empty ].

	(aStart = 0 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self class attributeRope
		attributes: attributes
		rope: (rope from: aStart to: anEnd)
]

{ #category : #'rope - enumeration' }
BlAttributeRope >> from: aStart to: anEnd do: aBlock [
	self rope from: aStart to: anEnd do: aBlock
]

{ #category : #'rope - inserting' }
BlAttributeRope >> insertItems: aCollection at: anIndex [

	^ self class attributeRope
		attributes: attributes
		rope: (rope insertItems: aCollection at: anIndex)
]

{ #category : #'rope - testing' }
BlAttributeRope >> isAttributed [
	<return: #Boolean>
	
	^ true
]

{ #category : #'rope - testing' }
BlAttributeRope >> isEmpty [
	"Attribute rope is empty then and only then when attributes and underlying rope are empty"
	
	^ self attributes isEmpty and: [ self rope isEmpty ]
]

{ #category : #'rope - testing' }
BlAttributeRope >> isLeaf [
	^ false
]

{ #category : #'rope - enumeration' }
BlAttributeRope >> iterator: aStart to: anEnd [
	^ BlAttributeRopeIterator rope: self from: aStart to: anEnd
]

{ #category : #accessing }
BlAttributeRope >> readStream [ 

	^ rope readStream
]

{ #category : #accessing }
BlAttributeRope >> rope [
	^ rope
]

{ #category : #'rope - replacing' }
BlAttributeRope >> simplified [
	<return: #BlRope>

	^ self class attributeRope
		attributes: attributes
		rope: (rope simplified)
]

{ #category : #'rope - accessing' }
BlAttributeRope >> size [
	^ rope size
]
