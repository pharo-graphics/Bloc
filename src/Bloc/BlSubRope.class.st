"
I a special type of rope used to represent a sub rope for the case when rebuilding the whole binary tree does not make since, so I just decorate an original rope limiting its access by using an offset and allowed length
"
Class {
	#name : #BlSubRope,
	#superclass : #BlRope,
	#instVars : [
		'rope',
		'offset',
		'length'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #'instance creation' }
BlSubRope class >> rope: aRope offset: anOffset length: aLength [
	^ self new
		rope: aRope offset: anOffset length: aLength;
		yourself
]

{ #category : #'rope - accessing' }
BlSubRope >> at: anIndex [
	anIndex > length
		ifTrue: [ self error: 'Sub rope index out of bounds: ', anIndex asString ].
	
	^ rope at: offset + anIndex
]

{ #category : #'rope - accessing' }
BlSubRope >> attributes: anAttributesCollection from: aStart to: anEnd [
	| anAttributeRope |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	anAttributesCollection
		ifEmpty: [ ^ self ].

	anAttributeRope := self rope attributes: anAttributesCollection from: aStart + offset to: anEnd + offset.
	
	^ anAttributeRope from: offset + 1 to: offset + length
]

{ #category : #'rope - accessing' }
BlSubRope >> children [
	^ { rope }
]

{ #category : #'rope - accessing' }
BlSubRope >> clearAttributes: aStart to: anEnd if: aBlock [
	| anClearedRope |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	anClearedRope := self rope clearAttributes: aStart + offset to: anEnd + offset if: aBlock.
	^ anClearedRope from: offset + 1 to: offset + length
]

{ #category : #'rope - deleting' }
BlSubRope >> delete: aStart to: anEnd [
	| afterDeletion |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	afterDeletion := self rope delete: aStart + offset to: anEnd + offset.
	^ afterDeletion
		from: offset + 1
		to: offset + length - (anEnd - aStart + 1)
]

{ #category : #'rope - accessing' }
BlSubRope >> depth [
	^ rope depth
]

{ #category : #'rope - enumeration' }
BlSubRope >> empty [
	"I delegate creation to the rope which I constrain"
	<return: #BlRope>

	^ self rope empty
]

{ #category : #'rope - accessing' }
BlSubRope >> from: aStart to: anEnd [
	self assertAccess: aStart.
	self assertAccess: anEnd.
	
	(aStart = 1 and: [ anEnd = self size ])
		ifTrue: [ ^ self ].

	^ self rope from: offset + aStart to: offset + anEnd
]

{ #category : #'rope - enumeration' }
BlSubRope >> from: aStart to: anEnd do: aBlock [
	self rope from: aStart + offset to: anEnd + offset do: aBlock
]

{ #category : #'rope - inserting' }
BlSubRope >> insertItems: aCollection at: anIndex [
	| afterInsertion |
	self assertIndexForInsert: anIndex.

	afterInsertion := self rope insertItems: aCollection at: anIndex + offset.
	^ afterInsertion from: offset + 1 to: offset + length + aCollection size
]

{ #category : #'rope - testing' }
BlSubRope >> isLeaf [
	^ false
]

{ #category : #'rope - enumeration' }
BlSubRope >> iterator: aStart to: anEnd [
	^ BlSubRopeIterator rope: self from: aStart to: anEnd
]

{ #category : #accessing }
BlSubRope >> offset [
	<return: #Number>

	^ offset
]

{ #category : #accessing }
BlSubRope >> rope [
	<return: #BlRope>

	^ rope
]

{ #category : #initialization }
BlSubRope >> rope: aRope offset: anOffset length: aLength [

	anOffset < 0
		ifTrue: [ self error: 'Negative offset: ', anOffset asString ].
	aLength < 0
		ifTrue: [ self error: 'Negative length: ', aLength asString ].
	(aLength + anOffset) > aRope size
		ifTrue: [ self error: 'Illegal offset (', anOffset asString,') and length (',aLength asString,') combination for sub rope of length ', aRope size asString ].

	rope := aRope.
	offset := anOffset.
	length := aLength
]

{ #category : #'rope - accessing' }
BlSubRope >> size [
	^ length
]
