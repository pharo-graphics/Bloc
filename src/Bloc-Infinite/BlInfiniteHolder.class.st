"
I represent a child holder  within infinite element and store data related to child - current position within data source, old position and maybe additional data needed by infinite layout

"
Class {
	#name : #BlInfiniteHolder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'itemElement',
		'position',
		'itemId',
		'flags',
		'infiniteElement'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #'private - position' }
BlInfiniteHolder >> bindAtPosition: aPosition [

	position := aPosition
]

{ #category : #'private - flags changing' }
BlInfiniteHolder >> clearReturnedFromScrap [
	self flags clearReturnedFromScrap
]

{ #category : #'private - flags changing' }
BlInfiniteHolder >> clearTmpDetached [
	self flags clearTmpDetached
]

{ #category : #accessing }
BlInfiniteHolder >> dataSourcePosition [
	"Returns the datasource position of the item represented by this ElementHolder."
	<return: #Number>

	^ infiniteElement dataSourcePositionOf: self
]

{ #category : #private }
BlInfiniteHolder >> detachRecycler [

	"Set returned from scrap flag to false"
	self clearReturnedFromScrap
]

{ #category : #private }
BlInfiniteHolder >> flagRemovedAndOffsetPosition: aNewPosition by: anOffset [

	self flags addRemoved.
	itemElement constraints infinite insetsDirty: true.
	position := aNewPosition
]

{ #category : #accessing }
BlInfiniteHolder >> flags [

	^ flags
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> infiniteElement [
	"Return an infinite element a child of which a hold.
	infiniteElement may be nil if I am not attached, for example if
	I am recycled or removed"
	<return: #BlInfiniteElement>

	^ infiniteElement
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> infiniteElement: anInfiniteElement [
	"Set an infinite element a child of which a hold.
	anInfiniteElement must not be nil"
	
	infiniteElement := anInfiniteElement
]

{ #category : #initialization }
BlInfiniteHolder >> initialize [

	super initialize.

	position := NoPosition.
	itemId := NoId.
	flags := BlInfiniteElementHolderFlags new
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isBound [
	^ self flags hasBound
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isInvalid [
	^ self flags hasInvalid
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isItemUpdated [
	^ self flags hasUpdate
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isRemoved [
	^ self flags hasRemoved
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isTmpDetached [
	^ self flags hasTmpDetached
]

{ #category : #accessing }
BlInfiniteHolder >> itemElement [

	^ itemElement
]

{ #category : #accessing }
BlInfiniteHolder >> itemId [
	"Returns The itemId represented by this ElementHolder if datasource has stable ids, `BlInfiniteElement noId` otherwise"

	^ itemId
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> itemId: anIdemId [

	itemId := anIdemId
]

{ #category : #private }
BlInfiniteHolder >> offsetPositionBy: anOffset [ 
	
	position := position + anOffset.
	itemElement constraints infinite insetsDirty: true
]

{ #category : #'private - position' }
BlInfiniteHolder >> position [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	<return: #Number>

	^ position
]

{ #category : #'private - invalidate' }
BlInfiniteHolder >> reset [

	flags clear.
	position := NoPosition.
	itemId := NoId
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> shouldIgnore [
	^ self flags hasIgnore
]

{ #category : #'private - flags changing' }
BlInfiniteHolder >> startIgnoring [
	"Start ignoring an element I represent"

	self flags addIgnore
]

{ #category : #'private - flags changing' }
BlInfiniteHolder >> stopIgnoring [
	"Stop ignoring an element I represent"

	self flags clearIgnore
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> wasReturnedFromScrap [
	<return: #Boolean>

	^ self flags hasReturnedFromScrap
]
