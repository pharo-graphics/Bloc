"
I represent a text selection defined as interval [from...to].

Monotone selection can not be empty

"
Class {
	#name : #BlMonotoneSelection,
	#superclass : #BlSelection,
	#instVars : [
		'from',
		'to'
	],
	#category : 'Bloc-Utilities - Selection'
}

{ #category : 'instance creation' }
BlMonotoneSelection class >> from: aFromIndex to: aToIndex [
	^ self basicNew initialize from: aFromIndex to: aToIndex
]

{ #category : 'instance creation' }
BlMonotoneSelection class >> new [
	^ self error: 'Use from:to: instead'
]

{ #category : 'comparing' }
BlMonotoneSelection >> < aMonotoneTextSelection [

	^ self from < aMonotoneTextSelection from
]

{ #category : 'comparing' }
BlMonotoneSelection >> <= aMonotoneTextSelection [

	^ self from <= aMonotoneTextSelection from
]

{ #category : 'comparing' }
BlMonotoneSelection >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	anotherObject class = self class
		ifFalse: [ ^ false ].
	
	^ anotherObject from = self from
		and: [ anotherObject to = self to ]
]

{ #category : 'comparing' }
BlMonotoneSelection >> > aMonotoneTextSelection [

	^ self from > aMonotoneTextSelection from
]

{ #category : 'comparing' }
BlMonotoneSelection >> >= aMonotoneTextSelection [

	^ self from >= aMonotoneTextSelection from
]

{ #category : 'invariant' }
BlMonotoneSelection >> assertInvariant [

	self
		assert: [ self invariant ]
		description: [ 'Class invariant must always hold' ].
]

{ #category : 'accessing' }
BlMonotoneSelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ #()
]

{ #category : 'arithmetic' }
BlMonotoneSelection >> complement: aMonotoneTextSelection [
	"Answer the complement of me and a given selection.
	Note: I return an empty selection if complement is empty and composite text selection
	if complement consists of two separate selections"
	<return: #BlSelection>
	
	(self overlaps: aMonotoneTextSelection)
		ifFalse: [ ^ self ].
		
	(aMonotoneTextSelection includes: self)
		ifTrue: [ ^ self class empty ].
	
	^ (aMonotoneTextSelection inside: self)
		"I am splitted in two selections"
		ifTrue: [
			BlCompositeSelection new
				select: self from to: aMonotoneTextSelection from;
				select: aMonotoneTextSelection to to: self to;
				yourself ]
		"result is one monotone selection"
		ifFalse: [ 			
			(self from < aMonotoneTextSelection from)
				ifTrue: [ self class from: self from to: (aMonotoneTextSelection from min: self to) ]
				ifFalse: [ self class from: (aMonotoneTextSelection to max: self from)  to: self to ]	]
]

{ #category : 'testing' }
BlMonotoneSelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise.
	If selection is [0.. 1] both 0 and 1 are within this selection"
	<return: #Boolean>
	
	^ self rangeIncludes: anIndex
]

{ #category : 'testing' }
BlMonotoneSelection >> containsIndex: anIndex [
	"Return true if selection indices include a given index, false otherwise.
	I am conceptually same as (self indices includes: anIndex)"
	<return: #Boolean>
	
	^ anIndex > self from
		and: [ anIndex <= self to ]
]

{ #category : 'copying' }
BlMonotoneSelection >> copyFrom: aStartIndex to: anEndIndex [
	aStartIndex <= self to
		ifTrue: [ ^ BlMonotoneSelection from: aStartIndex to: aStartIndex ].

	anEndIndex >= self from
		ifTrue: [ ^ BlMonotoneSelection from: anEndIndex to: anEndIndex ].

	^ BlSelection
		from: (aStartIndex max: self from)
		to: (anEndIndex min: self to)
]

{ #category : 'enumerating' }
BlMonotoneSelection >> do: aBlock [
	aBlock value: self
]

{ #category : 'accessing' }
BlMonotoneSelection >> from [
	"Return a text index of the first selected character"
	<return: #Number>
	
	^ from
]

{ #category : 'initialization' }
BlMonotoneSelection >> from: aFromIndex to: aToIndex [
	self
		assert: [ from isNil and: [ to isNil ] ]
		description: [ 'I am immutable and can not be changed' ].
	
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'From index must not be greater than to index' ].

	from := aFromIndex.
	to := aToIndex.

	self assertInvariant
]

{ #category : 'comparing' }
BlMonotoneSelection >> hash [
	^ self from hash bitXor: self to hash
]

{ #category : 'testing' }
BlMonotoneSelection >> includes: aMonotoneTextSelection [
	"Return true if I include a given selection, false otherwise"
	<return: #Boolean>
	
	^ aMonotoneTextSelection from >= self from
		and: [ aMonotoneTextSelection to <= self to ]
]

{ #category : 'accessing' }
BlMonotoneSelection >> indices [
	"Return a collection of selection indices.
	If the selection interval is [0..1] then selection indices will only contain
	one index {1}"
	<return: #Interval>

	self from
		ifNil: [ ^ 0 to: -1 ].

	^ self from + 1 to: self to
]

{ #category : 'testing' }
BlMonotoneSelection >> inside: aMonotoneTextSelection [
	"Return true if I am fully inside a given selection, false otherwise"
	<return: #Boolean>
	
	^ self from >= aMonotoneTextSelection from
		and: [ self to <= aMonotoneTextSelection to ]
]

{ #category : 'accessing' }
BlMonotoneSelection >> interval [
	"Return current text selection as interval"
	<return: #Interval>
	self from
		ifNil: [ ^ 0 to: 0 ].
	
	^ self from to: self to
]

{ #category : 'invariant' }
BlMonotoneSelection >> invariant [
	"Return true if class invariant holds, false otherwise.
	An invariant is that ===from=== must be always smaller or equal to ===to=== and both must not be negative"
	<return: #Boolean>

	^ from <= to
		and: [ from >= 0
			and: [ to >= 0 ] ]
]

{ #category : 'testing' }
BlMonotoneSelection >> isEmpty [
	"Return true if selection is empty, false otherwise"
	<return: #Boolean>

	^ self to <= self from
]

{ #category : 'testing' }
BlMonotoneSelection >> isNotEmpty [
	"Return true if selection is empty, false otherwise"
	<return: #Boolean>

	^ self from < self to
]

{ #category : 'testing' }
BlMonotoneSelection >> neighbours: aMonotoneTextSelection [
	"Return true if I am a neighour of a given interval, false otherwise.
	Overlapping intervals are not considered as neighbours"
	<return: #Boolean>
	
	"I am to the left"
	^ (self to = aMonotoneTextSelection from)
			"I am to the right"
			or: [ self from = aMonotoneTextSelection to ]
]

{ #category : 'testing' }
BlMonotoneSelection >> overlaps: aMonotoneTextSelection [
	"Return true I overlap with a given monotone text selection, false otherwise.
	Intervals such as [6, 7] and [7, 9] are considered to be overllaping,
	while intervals [5, 6] and [7, 9] do *not* overlap"
	<return: #Boolean>

	^ (self rangeIncludes: aMonotoneTextSelection from)
		or: [ (self rangeIncludes: aMonotoneTextSelection to)
			or: [ (aMonotoneTextSelection rangeIncludes: self from)
				or: [ (aMonotoneTextSelection rangeIncludes: self to) ] ] ]
]

{ #category : 'printing' }
BlMonotoneSelection >> printOn: aStream [
	aStream nextPut: $[.
	aStream nextPutAll: self from asString.
	aStream nextPutAll: ','.
	aStream nextPutAll: self to asString.
	aStream nextPut: $].
]

{ #category : 'testing' }
BlMonotoneSelection >> rangeIncludes: aNumber [
	"Return true if the number lies in the interval between from and to"
	<return: #Boolean>

	^ aNumber between: self from and: self to
]

{ #category : 'enumerating' }
BlMonotoneSelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"

	aBlock value: self
]

{ #category : 'accessing' }
BlMonotoneSelection >> to [
	"Return a text index of the last selected character"
	<return: #Number>

	^ to
]
