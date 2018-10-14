"
I am a special iterator used to iterate over sub-rope
"
Class {
	#name : #BlSubRopeIterator,
	#superclass : #BlRopeIterator,
	#instVars : [
		'subIterator'
	],
	#category : 'Bloc-DataStructure - Rope'
}

{ #category : #'iterator - accessing' }
BlSubRopeIterator >> attributes [
	^ subIterator attributes
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> detectAttribute: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."
	<return: #BlTextAttribute or: #Object>

	^ subIterator
		detectAttribute: aBlock
		ifFound: aFoundBlock
		ifNone: anExceptionBlock
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

{ #category : #'iterator - accessing' }
BlSubRopeIterator >> position [
	^ subIterator position - rope offset
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
BlSubRopeIterator >> selectAttributes: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #SequenceableCollection of: #BlTextAttribute>

	^ subIterator selectAttributes: aBlock
]

{ #category : #'iterator - enumeration' }
BlSubRopeIterator >> skip: aNumber [
	subIterator skip: aNumber
]
