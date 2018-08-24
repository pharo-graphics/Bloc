Class {
	#name : #BlInfiniteElementInfoStoreRecord,
	#superclass : #Object,
	#instVars : [
		'flags',
		'preInfo',
		'postInfo'
	],
	#classInstVars : [
		'pool'
	],
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #cleanup }
BlInfiniteElementInfoStoreRecord class >> cleanUp [
	super cleanUp.
	
	pool := nil
]

{ #category : #recycling }
BlInfiniteElementInfoStoreRecord class >> drainCache [

	[ self pool acquire isNotNil ] whileTrue
]

{ #category : #'instance creation' }
BlInfiniteElementInfoStoreRecord class >> obtain [
	^ self pool acquire
		ifNil: [ self new ]
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord class >> pool [
	^ pool ifNil: [ pool := BlInfiniteSimplePool new: self poolSize ]
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord class >> poolSize [
	^ 20
]

{ #category : #recycling }
BlInfiniteElementInfoStoreRecord class >> recycle: aStoreRecord [
	aStoreRecord reset.
	self pool release: aStoreRecord
]

{ #category : #flags }
BlInfiniteElementInfoStoreRecord >> flags [
	^ flags
]

{ #category : #initialization }
BlInfiniteElementInfoStoreRecord >> initialize [
	super initialize.
	
	flags := BlInfiniteInfoStoreRecordFlags new
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord >> postInfo [
	^ postInfo
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord >> postInfo: anObject [
	postInfo := anObject
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord >> preInfo [
	^ preInfo
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord >> preInfo: anObject [
	preInfo := anObject
]

{ #category : #accessing }
BlInfiniteElementInfoStoreRecord >> reset [
	flags clear.
	preInfo := nil.
	postInfo := nil
]
