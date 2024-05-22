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
		'preLayoutPosition',
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

{ #category : #'private - position' }
BlInfiniteHolder >> clearOldPosition [

	preLayoutPosition := NoPosition
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
BlInfiniteHolder >> flagRemovedAndOffsetPosition: aNewPosition by: anOffset applyToPreLayout: applyToPreLayout [

	self flags addRemoved.
	self offsetPositionBy: anOffset applyToPreLayout: applyToPreLayout.
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
	preLayoutPosition := NoPosition.
	itemId := NoId.
	flags := BlInfiniteElementHolderFlags new
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isBound [
	^ self flags hasBound
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isChanged [
	^ self flags hasUpdate
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isInvalid [
	^ self flags hasInvalid
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isRemoved [
	^ self flags hasRemoved
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isTmpDetached [
	^ self flags hasTmpDetached
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isUpdated [
	^ self flags hasUpdate
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

{ #category : #accessing }
BlInfiniteHolder >> layoutPosition [
	"Returns the position of the ElementHolder in terms of the latest layout pass"

	^ preLayoutPosition = NoPosition
		ifTrue: [ position ]
		ifFalse: [ preLayoutPosition ]
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> needsUpdate [
	^ self flags hasUpdate
]

{ #category : #private }
BlInfiniteHolder >> offsetPositionBy: anOffset applyToPreLayout: shouldApplyOnPreLayout [
	
	preLayoutPosition = NoPosition
		ifTrue: [ preLayoutPosition := position ].
	
	shouldApplyOnPreLayout
		ifTrue: [ preLayoutPosition := preLayoutPosition + anOffset ].
	
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
	itemId := NoId.
	preLayoutPosition := NoPosition
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
