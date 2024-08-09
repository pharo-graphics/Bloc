"
An Interval represents a contiguous range of values that lie between the interval's #min and #max values .

I am different from `Interval` in a sense that I don't include #max and my size is computed as (max - min)

Intervals are immutable so may be passed as values and used as keys in hash tables.
It is not necessary to have multiple instances of Intervals which have the same #min and #max values.

Intervals are often written as [min, max) and represent the set of values min <= x < max.

I am used by `BlGridLayoutArc`

"
Class {
	#name : #BlGridLayoutInterval,
	#superclass : #Object,
	#instVars : [
		'min',
		'max'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'instance creation' }
BlGridLayoutInterval class >> min: aMinValue max: aMaxValue [

	^ self new
		  min: aMinValue max: aMaxValue;
		  yourself
]

{ #category : #comparing }
BlGridLayoutInterval >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ min = anObject min and: [ max = anObject max ]
]

{ #category : #comparing }
BlGridLayoutInterval >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ min hash bitXor: max hash
]

{ #category : #accessing }
BlGridLayoutInterval >> inversed [

	^ self class min: max max: min
]

{ #category : #accessing }
BlGridLayoutInterval >> max [

	^ max
]

{ #category : #accessing }
BlGridLayoutInterval >> min [

	^ min
]

{ #category : #initialization }
BlGridLayoutInterval >> min: aMinValue max: aMaxValue [
	"Construct a new interval"

	min ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	max ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].

	min := aMinValue.
	max := aMaxValue
]

{ #category : #printing }
BlGridLayoutInterval >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' min: ';
		print: min.
	aStream
		nextPutAll: ' max: ';
		print: max
]

{ #category : #accessing }
BlGridLayoutInterval >> size [

	^ max - min
]
