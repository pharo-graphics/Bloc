"
I am a special iterator used to iterate over attribute rope
"
Class {
	#name : #BlAttributeRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'subIterator'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'iterator - attributes' }
BlAttributeRopeIterator >> attributes [
	"Return a collection of rope attributes at a current position without duplicates"
	<return: #Collection of: #Objects>

	^ BlAttributeRope
		mergeAttributes: subIterator attributes
		and: rope attributes
]

{ #category : #'iterator - testing' }
BlAttributeRopeIterator >> hasNext [
	^ subIterator hasNext
]

{ #category : #'iterator - testing' }
BlAttributeRopeIterator >> hasPrevious [
	^ subIterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> next [
	^ subIterator next
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> nextSpan [
	| aSpan theAttributes |

	theAttributes := rope attributes.
	aSpan := subIterator nextSpan. "span without my rope's attributes"
	aSpan == rope rope
		ifTrue: [ ^ rope ].

	^ aSpan attributes: theAttributes
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> peek [
	^ subIterator peek
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> peer [
	^ subIterator peer
]

{ #category : #'iterator - accessing' }
BlAttributeRopeIterator >> position [
	^ subIterator position
]

{ #category : #copying }
BlAttributeRopeIterator >> postCopy [
	super postCopy.

	subIterator := subIterator copy
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> previous [
	^ subIterator previous
]

{ #category : #'instance creation' }
BlAttributeRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.

	subIterator := aRope rope iterator: aStart to: anEnd
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> skip: aNumber [
	subIterator skip: aNumber
]
