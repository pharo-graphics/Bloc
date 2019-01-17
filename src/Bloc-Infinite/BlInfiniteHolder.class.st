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
		'previousPosition',
		'itemId',
		'itemType',
		'preLayoutPosition',
		'flags',
		'recycler',
		'isInChangeScrap',
		'infiniteElement',
		'recyclableCount',
		'shadowedHolder',
		'shadowingHolder',
		'payloads'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-! Core'
}

{ #category : #'instance creation' }
BlInfiniteHolder class >> of: anElement [
	^ self new
		initializeWith: anElement;
		yourself
]

{ #category : #'accessing - payload' }
BlInfiniteHolder >> addEmptyPayload [

	self flags addDataSourceFullUpdate
]

{ #category : #'accessing - payload' }
BlInfiniteHolder >> addPayload: anObject [

	anObject
		ifNil: [ ^ self addEmptyPayload ].

	self flags hasDataSourceFullUpdate
		ifFalse: [ payloads add: anObject ]
]

{ #category : #'private - position' }
BlInfiniteHolder >> clearOldPosition [

	previousPosition := NoPosition.
	preLayoutPosition := NoPosition
]

{ #category : #'accessing - payload' }
BlInfiniteHolder >> clearPayload [

	payloads ifNotNil: [ payloads removeAll ].
	self flags clearDataSourceFullUpdate
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

	^ infiniteElement
		ifNil: [ NoPosition ]
		ifNotNil: [ :infEl | infEl dataSourcePositionOf: self ]
]

{ #category : #private }
BlInfiniteHolder >> detachInfiniteElement [

	infiniteElement := nil
]

{ #category : #private }
BlInfiniteHolder >> detachRecycler [
	"Detaches recycler setting it to nil and isInChangeScrap to false.
	Additionally set returned from scrap flag to false"
	recycler := nil.
	isInChangeScrap := false.
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
	self assert: anInfiniteElement isNotNil.
	
	infiniteElement := anInfiniteElement
]

{ #category : #initialization }
BlInfiniteHolder >> initialize [
	super initialize.
	
	position := NoPosition.
	previousPosition := NoPosition.
	preLayoutPosition := NoPosition.
	itemId := NoId.
	flags := BlInfiniteElementHolderFlags new.
	itemType := BlInfiniteItemType invalid.
	isInChangeScrap := false.
	recyclableCount := 0.
	payloads := OrderedCollection new
]

{ #category : #initialization }
BlInfiniteHolder >> initializeWith: anElement [
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'An element must not be nil!' ].
	
	itemElement := anElement
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isBound [
	^ self flags hasBound
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isChanged [
	^ self flags hasUpdate
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> isInChangeScrap [
	"Return true if I am inside of change scrap of attached
	recycler, false otherwise.
	If I am not attached to recycler return false"
	<return: #Boolean>
	
	self
		assert: [ isInChangeScrap ifTrue: [ recycler isNotNil ] ifFalse: [ true ] ]
		description: [ 'Recycler must be attached if I am in change scrap' ].
	
	^ isInChangeScrap
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isInvalid [
	^ self flags hasInvalid
]

{ #category : #'private - testing' }
BlInfiniteHolder >> isRecyclable [
	^ self flags hasNotRecyclable not
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> isRecyclable: aBoolean [
	"Informs the recycler whether this item can be recycled or not.
	Elements which are not recyclable will not be reused for other items until isRecyclable: is
	later set to true. Message sends to isRecyclable: should always be paired (one send of isRecyclable: false
	should always be matched with a later message send to isRecyclable: true).
	Pairs of sends may be nested, as the state is internally reference-counted"

	recyclableCount := aBoolean
		ifTrue: [ recyclableCount - 1 ]
		ifFalse: [ recyclableCount + 1 ].
	
	recyclableCount < 0
		ifTrue: [ 
			self error: 'isRecyclable decremented below 0. Unmatched message sent of isRecyclable:!'.
			recyclableCount := 0 ].
	
	(aBoolean not and: [ recyclableCount = 1 ])
		ifTrue: [ self flags addNotRecyclable ].

	(aBoolean and: [ recyclableCount = 0 ])
		ifTrue: [ self flags clearNotRecyclable ]
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isRemoved [
	^ self flags hasRemoved
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> isScrap [
	"Return true if an item I represent is added to scrap, false otherwise"
	<return: #Boolean>

	^ recycler isNotNil
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
	<return: #Number>

	^ itemId
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> itemId: anIdemId [
	itemId := anIdemId
]

{ #category : #accessing }
BlInfiniteHolder >> itemType [
	"Return view type of this ElementHolder"
	<return: #BlInfiniteItemType>

	^ itemType
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> itemType: anItemType [
	itemType := anItemType
]

{ #category : #accessing }
BlInfiniteHolder >> layoutPosition [
	"Returns the position of the ElementHolder in terms of the latest layout pass"
	<return: #Number>

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
	
	previousPosition = NoPosition
		ifTrue: [ previousPosition := position ].
	
	preLayoutPosition = NoPosition
		ifTrue: [ preLayoutPosition := position ].
	
	shouldApplyOnPreLayout
		ifTrue: [ preLayoutPosition := preLayoutPosition + anOffset ].
	
	position := position + anOffset.
	itemElement constraints infinite insetsDirty: true
]

{ #category : #'accessing - payload' }
BlInfiniteHolder >> payloads [
	"I return un-modifiable list of paylods taking update request into account"
	<return: #Array>

	^ self flags hasDataSourceFullUpdate
		ifFalse: [ 
			payloads
				"Initial state, no update being requested"
				ifEmpty: [ #() ]
				ifNotEmpty: [ payloads ] ]
			"a full update has been requested"
		ifTrue: [ #() ]
]

{ #category : #'private - position' }
BlInfiniteHolder >> position [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	<return: #Number>

	^ position
]

{ #category : #'private - position' }
BlInfiniteHolder >> position: aPosition [
	"For inner use ONLY!"
	position := aPosition
]

{ #category : #'private - position' }
BlInfiniteHolder >> preLayoutPosition [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	^ preLayoutPosition
]

{ #category : #'private - position' }
BlInfiniteHolder >> preLayoutPosition: aPosition [
	"For inner use ONLY!"
	preLayoutPosition := aPosition
]

{ #category : #'private - position' }
BlInfiniteHolder >> previousPosition [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	^ previousPosition
]

{ #category : #'private - position' }
BlInfiniteHolder >> previousPosition: aNumber [
	"For inner use ONLY! Instead try #layoutPosition or #dataSourcePosition"
	previousPosition := aNumber
]

{ #category : #'private - accessing' }
BlInfiniteHolder >> recycler: aRecycler inChangeScrap: aBoolean [
	recycler := aRecycler.
	isInChangeScrap := aBoolean
]

{ #category : #'private - invalidate' }
BlInfiniteHolder >> reset [

	flags clear.
	position := NoPosition.
	previousPosition := NoPosition.
	itemId := NoId.
	preLayoutPosition := NoPosition.
	recyclableCount := 0.
	shadowedHolder := nil.
	shadowingHolder := nil.
	self clearPayload
]

{ #category : #'private - position' }
BlInfiniteHolder >> saveOldPosition [

	previousPosition = NoPosition
		ifTrue: [ previousPosition := position ]
]

{ #category : #accessing }
BlInfiniteHolder >> shadowedHolder: anElementHolder [
	shadowedHolder := anElementHolder
]

{ #category : #accessing }
BlInfiniteHolder >> shadowingHolder: anElementHolder [
	shadowingHolder := anElementHolder
]

{ #category : #'private - testing' }
BlInfiniteHolder >> shouldBeKeptAsChild [
	"Return true if we have animations referring to this element holder or not.
	This is inverted, a bit more domain specific version of isRecyclable"
	<return: #Boolean>

	^ 	self flags hasNotRecyclable
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

{ #category : #private }
BlInfiniteHolder >> unscrap [
	"Unscrap me from recycler detaching it from me as result"

	recycler unscrapHolder: self
]

{ #category : #'private - flags testing' }
BlInfiniteHolder >> wasReturnedFromScrap [
	<return: #Boolean>

	^ self flags hasReturnedFromScrap
]
