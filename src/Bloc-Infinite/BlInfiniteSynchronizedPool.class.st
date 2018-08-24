"
I am synchronized pool
"
Class {
	#name : #BlInfiniteSynchronizedPool,
	#superclass : #BlInfiniteSimplePool,
	#instVars : [
		'monitor'
	],
	#category : 'Bloc-Infinite-Pool'
}

{ #category : #pool }
BlInfiniteSynchronizedPool >> acquire [
	^ monitor critical: [ super acquire ]
]

{ #category : #initialization }
BlInfiniteSynchronizedPool >> initialize [
	super initialize.
	
	monitor := Mutex new
]

{ #category : #pool }
BlInfiniteSynchronizedPool >> release: anObject [
	^ monitor critical: [ super release: anObject ]
]
