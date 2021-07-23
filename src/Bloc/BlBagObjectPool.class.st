"
I am a dynamic object pool that grows to acomodate a lot of objects

"
Class {
	#name : 'BlBagObjectPool',
	#superclass : 'BlObjectPool',
	#instVars : [
		'poolSize',
		'maxPoolSize',
		'pool'
	],
	#category : 'Bloc-Basic-Support'
}

{ #category : 'private' }
BlBagObjectPool class >> arrayType [
	^ IdentitySet
]

{ #category : 'instance creation' }
BlBagObjectPool class >> new [
	^ self basicNew
		setPool: (self arrayType new);
		initialize;
		maxPoolSize: Float infinity
]

{ #category : 'instance creation' }
BlBagObjectPool class >> new: anInteger [
	^ self basicNew
		setPool: (self arrayType new: anInteger);
		initialize;
		maxPoolSize: anInteger
]

{ #category : 'pool' }
BlBagObjectPool >> acquire [
	"Returns an object from the pool if there is one,
	or nil otherwise"
	<return: #Object or: nil>

	^ poolSize > 0
		ifTrue: [ 
			|  object |
			object := pool remove: pool anyOne.
			poolSize := poolSize - 1.
			object ]
		ifFalse: [ nil ]
]

{ #category : 'initialization' }
BlBagObjectPool >> initialize [
	super initialize.

	poolSize := 0.
	maxPoolSize := 0
]

{ #category : 'testing' }
BlBagObjectPool >> isInPool: anObject [
	"Return true of anObject is currently in the pool,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.
	
	^ pool includes: anObject
]

{ #category : 'initialization' }
BlBagObjectPool >> maxPoolSize: aNumber [
	maxPoolSize := aNumber
]

{ #category : 'pool' }
BlBagObjectPool >> release: anObject [
	"Adds anObject to the pool and return true if successfully added,
	false otherwise.
	anObject must not be nil"
	<return: #Boolean>
	self assert: anObject isNotNil.

	(self isInPool: anObject)
		ifTrue: [ self error: anObject asString, ' is already in the pool!' ].

	^ (poolSize < maxPoolSize)
		ifTrue: [ 
			pool add: anObject.
			poolSize := poolSize + 1.
			true
		]
		ifFalse: [ false ]
]

{ #category : 'initialization' }
BlBagObjectPool >> setPool: aCollection [
	pool := aCollection
]
