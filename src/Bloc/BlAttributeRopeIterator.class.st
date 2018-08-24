"
I am a special iterator used to iterate over attribute rope
"
Class {
	#name : #BlAttributeRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'subIterator'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #'iterator - accessing' }
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

{ #category : #accessing }
BlAttributeRopeIterator >> hasPrevious [
	^ subIterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> next [
	^ subIterator next
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> nextSpan [
	| run theAttributes |

	theAttributes := self rope attributes.
	run := subIterator nextSpan. "span without my rope's attributes"
	run == rope rope
		ifTrue: [ ^ rope ].

	^ run attributes: theAttributes from: 1 to: run size
]

{ #category : #'iterator - enumeration' }
BlAttributeRopeIterator >> peek [
	^ subIterator peek
]

{ #category : #'iterator - accessing' }
BlAttributeRopeIterator >> position [
	^ subIterator position
]

{ #category : #accessing }
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
