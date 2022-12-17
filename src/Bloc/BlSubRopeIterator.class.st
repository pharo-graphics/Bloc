"
I am a special iterator used to iterate over sub-rope

"
Class {
	#name : #BlSubRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'subIterator'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #'iterator - accessing' }
BlSubRopeIterator >> attributes [
	^ subIterator attributes
]

{ #category : #'iterator - testing' }
BlSubRopeIterator >> hasNext [
	^ subIterator hasNext
]

{ #category : #accessing }
BlSubRopeIterator >> hasPrevious [
	^ subIterator hasPrevious
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> next [
	^ subIterator next
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> nextSpan [
	^ subIterator nextSpan
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> peek [
	^ subIterator peek
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> peer [
	^ subIterator peer
]

{ #category : #'iterator - accessing' }
BlSubRopeIterator >> position [
	^ subIterator position - rope offset
]

{ #category : #copying }
BlSubRopeIterator >> postCopy [
	super postCopy.

	subIterator := subIterator copy
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> previous [
	^ subIterator previous
]

{ #category : #'instance creation' }
BlSubRopeIterator >> rope: aRope from: aStart to: anEnd [
	super rope: aRope from: aStart to: anEnd.
	subIterator := aRope rope iterator: aStart + aRope offset to: anEnd + aRope offset
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> skip: aNumber [
	subIterator skip: aNumber
]
