"
I am a non-synchronized concrete pool implementation
"
Class {
	#name : #BlInfiniteSimplePool,
	#superclass : #BlInfinitePool,
	#instVars : [
		'pool',
		'poolSize'
	],
	#category : 'Bloc-Infinite-Pool'
}

{ #category : #private }
BlInfiniteSimplePool class >> arrayType [
	^ Array
]

{ #category : #'instance creation' }
BlInfiniteSimplePool class >> defaultMaxPoolSize [
	^ 10
]

{ #category : #'instance creation' }
BlInfiniteSimplePool class >> new [
	^ self new: self defaultMaxPoolSize
]

{ #category : #'instance creation' }
BlInfiniteSimplePool class >> new: anInteger [
	^ self basicNew setPool: (self arrayType new: anInteger); initialize
]

{ #category : #pool }
BlInfiniteSimplePool >> acquire [
	"Returns an object from the pool if there is one,
	or nil otherwise"
	<return: #Object or: nil>

	^ poolSize > 0
		ifTrue: [ 
			|  object |
			object := pool at: poolSize.
			pool at: poolSize put: nil.
			poolSize := poolSize - 1.
			object ]
		ifFalse: [ nil ]
]

{ #category : #initialization }
BlInfiniteSimplePool >> initialize [
	super initialize.

	poolSize := 0
]

{ #category : #private }
BlInfiniteSimplePool >> isInPool: anObject [
	"Return true of anObject is currently in the pool,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.
	
	1 to: poolSize do: [ :i |
		(pool at: i) == anObject
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #pool }
BlInfiniteSimplePool >> release: anObject [
	"Adds anObject to the pool and return true if successfully added,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.

	(self isInPool: anObject)
		ifTrue: [ self error: anObject asString, ' is already in the pool!' ].

	^ (poolSize < pool size)
		ifTrue: [ 
			pool at: poolSize + 1 put: anObject.
			poolSize := poolSize + 1.
			true
		]
		ifFalse: [ false ]
]

{ #category : #private }
BlInfiniteSimplePool >> setPool: anArray [
	pool := anArray
]
