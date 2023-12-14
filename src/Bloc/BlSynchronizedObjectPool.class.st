Class {
	#name : 'BlSynchronizedObjectPool',
	#superclass : 'BlObjectPool',
	#instVars : [
		'pool',
		'monitor'
	],
	#category : 'Bloc-Basic-Support',
	#package : 'Bloc',
	#tag : 'Basic-Support'
}

{ #category : 'instance creation' }
BlSynchronizedObjectPool class >> pool: anObjectPool [
	^ self new initializeWith: anObjectPool
]

{ #category : 'pool' }
BlSynchronizedObjectPool >> acquire [
	^ monitor critical: [ pool acquire ]
]

{ #category : 'initialization' }
BlSynchronizedObjectPool >> initialize [
	super initialize.
	
	monitor := Mutex new
]

{ #category : 'initialization' }
BlSynchronizedObjectPool >> initializeWith: anObjectPool [
	pool := anObjectPool
]

{ #category : 'pool' }
BlSynchronizedObjectPool >> release: anObject [
	^ monitor critical: [ pool release: anObject ]
]
