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
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #initialization }
BlAttributeRope class >> attributes: anAttributeCollection rope: aRope [
	^ self new
		attributes: anAttributeCollection rope: aRope;
		yourself
]

{ #category : #utilities }
BlAttributeRope class >> mergeAttributes: aCollectionOfAttributes and: anotherCollectionOfAttributes [
	"Merge two collection of attributes letting anotherCollectionOfAttributes to override
	attributes from aCollectionOfAttributes based on its type"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	((aCollectionOfAttributes isKindOf: HashedCollection) or: [ anotherCollectionOfAttributes isKindOf: HashedCollection ])
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.

	anotherCollectionOfAttributes reverseDo: [ :each | anOrderedDictionary at: each put: each ].
	aCollectionOfAttributes reverseDo: [ :each | anOrderedDictionary at: each put: each ].

	^ Array streamContents: [ :aStream | anOrderedDictionary keys reverseDo: [ :anObject | aStream nextPut: anObject ] ]
]

{ #category : #utilities }
BlAttributeRope class >> removeDuplicates: aCollection [
	"Remove duplicates from a given collection preserving the original order"
	<return: #Collection of: #Object>
	| anOrderedDictionary |
	
	(aCollection isKindOf: HashedCollection)
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].
	
	anOrderedDictionary := OrderedDictionary new.
	aCollection reverseDo: [ :each | anOrderedDictionary at: each put: each ].

	^ Array streamContents: [ :aStream | anOrderedDictionary keys reverseDo: [ :anObject | aStream nextPut: anObject ] ]
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

{ #category : #'rope - accessing' }
BlAttributeRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	| anAttributeRope |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].
	
	anAttributeRope := (self rope from: aStart to: anEnd)
		attributes: (self class mergeAttributes: self attributes and: anAttributesCollection)
		from: 1
		to: anEnd - aStart + 1.

	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ anAttributeRope ].

	aStart = 1 ifTrue: [ 
		^ self class
			concatenate: anAttributeRope
			and: (self from: anEnd + 1 to: self size) ].
	
	anEnd = self size ifTrue: [ 
		^ self class
			concatenate: (self from: 1 to: aStart - 1)
			and: anAttributeRope ].

	^ (self from: 1 to: aStart - 1) append: (anAttributeRope append: (self from: anEnd + 1 to: self size))
]

{ #category : #initialization }
BlAttributeRope >> attributes: theAttributes rope: aRope [

	(theAttributes isKindOf: HashedCollection)
		ifTrue: [ self notify: 'Hashed collection is unordered, so the order of attributes will be ignored!' ].

	attributes := self class removeDuplicates: theAttributes.
	rope := aRope
]

{ #category : #'rope - accessing' }
BlAttributeRope >> children [
	^ { rope }
]

{ #category : #'rope - accessing' }
BlAttributeRope >> clearAttributes: aStart to: anEnd if: aBlock [
	| aClearedRope selectedAttributes aSubRope aSubRopeStart aSubRopeEnd aMyStart aMyEnd |
	self assertAccessFrom: aStart to: anEnd.

	selectedAttributes := self attributes reject: [ :anAssociation | aBlock value: anAssociation value ].

	aSubRope := self rope from: aStart to: anEnd.
	aSubRopeStart := (1 min: aSubRope size).
	aSubRopeEnd := anEnd - aStart + (1 min: aSubRope size).
	
	aMyStart := 1 min: self size.
	aMyEnd := self size.
	
	aClearedRope := aSubRope
		clearAttributes: aSubRopeStart
		to: aSubRopeEnd
		if: aBlock.

	selectedAttributes ifNotEmpty: [ 
		aClearedRope := aClearedRope
			attributes: selectedAttributes
			from: aSubRopeStart
			to: aSubRopeEnd ].

	(aStart = aMyStart and: [ anEnd = aMyEnd ])
		ifTrue: [ ^ aClearedRope ].

	aStart = aMyStart ifTrue: [ 
		^ self class
			concatenate: aClearedRope
			and: (self from: anEnd + 1 to: aMyEnd) ].
	
	anEnd = self size ifTrue: [ 
		^ self class
			concatenate: (self from: 1 to: aStart - 1)
			and: aClearedRope ].

	^ (self from: 1 to: aStart - 1) append: (aClearedRope append: (self from: anEnd + 1 to: self size))
]

{ #category : #'rope - deleting' }
BlAttributeRope >> delete: aStart to: anEnd [

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
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	(aStart = 1 and: [ anEnd = self size ])
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
BlAttributeRope >> isLeaf [
	^ false
]

{ #category : #'rope - enumeration' }
BlAttributeRope >> iterator: aStart to: anEnd [
	^ BlAttributeRopeIterator rope: self from: aStart to: anEnd
]

{ #category : #accessing }
BlAttributeRope >> rope [
	^ rope
]

{ #category : #'rope - accessing' }
BlAttributeRope >> size [
	^ rope size
]
