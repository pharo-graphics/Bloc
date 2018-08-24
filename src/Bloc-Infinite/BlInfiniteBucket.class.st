"
I am an implementation of a Bitset that provides methods to offset indices
"
Class {
	#name : #BlInfiniteBucket,
	#superclass : #Object,
	#instVars : [
		'next',
		'array'
	],
	#category : 'Bloc-Infinite-Utils'
}

{ #category : #accessing }
BlInfiniteBucket >> clear: index [
	index > array size
		ifTrue: [
			next ifNotNil: [ :n | n clear: index - array size ] ]
		ifFalse: [
			array byteAt: index put: false asBit ]
]

{ #category : #accessing }
BlInfiniteBucket >> countOnesBefore: anIndex [
	| counter index |
	index := anIndex.
	counter := 0.
	next
		ifNil: [ index > array size
				ifTrue: [ ^ array count: [ :each | each = true asBit ] ] ].

	index > array size
		ifTrue: [
			counter := next countOnesBefore: index - array size.
			index := array size + 1 ].

	1 to: index - 1 do: [ :i | 
		(array byteAt: i) = true asBit
			ifTrue: [ counter := counter + 1 ] ].
	^ counter
]

{ #category : #accessing }
BlInfiniteBucket >> ensureNext [

	next ifNil: [ next := BlInfiniteBucket new ]
]

{ #category : #accessing }
BlInfiniteBucket >> get: index [
	
	^ index > array size
		ifTrue: [
			self ensureNext.
			next get: index - array size ]
		ifFalse: [
			(array byteAt: index) = true asBit  ]
]

{ #category : #initialization }
BlInfiniteBucket >> initialize [
	super initialize.
	
	self reset
]

{ #category : #accessing }
BlInfiniteBucket >> insert: aBoolean at: index [
	index > array size
		ifTrue: [ 
			self ensureNext.
			next insert: aBoolean at: index - array size ]
		ifFalse: [ 
			| last prevArray|
			last := array last = true asBit.
			prevArray := array.
			array := self newArray.
			array replaceFrom: index + 1 to: prevArray size with: prevArray startingAt: index.
			array replaceFrom: 1 to: index - 1 with: prevArray startingAt: 1.
			array byteAt: index put: aBoolean asBit.
			(last or: [ next isNotNil ])
				ifTrue: [ 
					self ensureNext.
					next insert: last at: 1 ] ]
			

]

{ #category : #initialization }
BlInfiniteBucket >> newArray [
	^ ByteArray new: 64
]

{ #category : #accessing }
BlInfiniteBucket >> remove: index [

	^ index > array size
		ifTrue: [ 
			self ensureNext.
			next remove: index - array size ]
		ifFalse: [ 
			| value |
			value := (array byteAt: index) = true asBit.
			array replaceFrom: index to: array size - 1 with: array startingAt: index + 1.
			array byteAt: array size put: (next
				ifNil: [ false asBit ]
				ifNotNil: [ (next get: 1) asBit ]).
			next
				ifNotNil: [ next remove: 1 ].
			value ]
]

{ #category : #accessing }
BlInfiniteBucket >> reset [
	next ifNotNil: #reset.
	array := self newArray
]

{ #category : #accessing }
BlInfiniteBucket >> set: index [

	index > array size
		ifTrue: [ 
			self ensureNext.
			next set: index - array size ]
		ifFalse: [
			array byteAt: index put: true asBit ]
]
