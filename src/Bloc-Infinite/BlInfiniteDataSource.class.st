"
I provide a binding from an app-specific data set to elements that are displayed within an InfiniteElement
"
Class {
	#name : #BlInfiniteDataSource,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'eventDispatcher',
		'hasStableIds'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #'instance creation' }
BlInfiniteDataSource >> bindHolder: anElementHolder at: aPosition [

	anElementHolder position: aPosition.
	self hasStableIds
		ifTrue: [ anElementHolder itemId: (self itemIdAt: aPosition) ].
	anElementHolder flags
		clearUpdate;
		clearInvalid;
		clearDataSourcePositionUnknown;
		addBound.

	self onBindHolder: anElementHolder at: aPosition payloads: anElementHolder payloads.
	anElementHolder clearPayload.
	anElementHolder itemElement constraints infinite insetsDirty: true
]

{ #category : #'instance creation' }
BlInfiniteDataSource >> createHolder: anInfiniteElement type: anItemType [
	| anElementHolder |
	anElementHolder := self onCreateHolder: anInfiniteElement type: anItemType.
	anElementHolder itemType: anItemType.
	^ anElementHolder
]

{ #category : #'event management accessing' }
BlInfiniteDataSource >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'event management testing' }
BlInfiniteDataSource >> hasEventHandlers [
	"Returns true if one or more event handlers are attached to this data source"
	<return: #Boolean>

	^ self eventDispatcher handlers handlers isNotEmpty
]

{ #category : #testing }
BlInfiniteDataSource >> hasStableIds [
	"Returns true if this data source publishes a unique value that can
	act as a key for the item at a given position in the data set. If that item is relocated
	in the data set, the ID returned for that item should be the same"
	<return: #Number>

	^ hasStableIds
]

{ #category : #initialization }
BlInfiniteDataSource >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	hasStableIds := false
]

{ #category : #accessing }
BlInfiniteDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlInfiniteDataSource >> itemIdAt: aPosition [
	"Return the stable ID for the item at aPosition.
	If #hasStableIds would return false this method should return ===NoId===.
	The default implementation of this method returns ===NoId==="
	<return: #Number>

	^ NoId
]

{ #category : #accessing }
BlInfiniteDataSource >> itemTypeAt: aPosition [
	"Return the element type of the item at aPosition for the purposes of element recycling.
	The default implementation of this method returns ===BlInfiniteItemType invalid===,
	making the assumption of a single element type for the data source."
	<return: #BlInfiniteItemType>

	^ BlInfiniteItemType invalid
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyChanged [
	"Notify any registered event handlers that the data set has changed.
	There are two different classes of data change events, item changes and structural
	changes. Item changes are when a single item has its data updated but no positional
	changes have occurred. Structural changes are when items are inserted, removed or moved
	within the data set.
	This event does not specify what about the data set has changed, forcing
	any observers to assume that all existing items and structure may no longer be valid.
	InfiniteLayout will be forced to fully rebind and relayout all visible elements."

	self notifyWithEvent: (BlInfiniteDataSourceChanged new
		dataSource: self;
		yourself)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyItemMoved: aFromPosition to: aToPosition [
	"Notify any registered event handlers that the item reflected at aFromPosition
	has been moved to aToPosition.
	This is a structural change event. Representations of other existing items in the
	data set are still considered up to date and will not be rebound, though their
	positions may be altered"

	self notifyWithEvent: (BlInfiniteDataSourceItemRangeMoved
		from: aFromPosition
		to: aToPosition)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyItemsChanged: anInterval [
	"Notify any registered event handlers that the itemCount items starting at aPosition have changed.
	This is an item change event, not a structural change event. It indicates that
	any reflection of the data in the given position range is out of date and should
	be updated. The items in the given range retain the same identity"
	
	self notifyWithEvent: (BlInfiniteDataSourceItemRangeChanged
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyItemsChanged: anInterval payload: anObject [
	"Notify any registered event handlers that the itemCount items starting at aPosition have changed.
	This is an item change event, not a structural change event. It indicates that
	any reflection of the data in the given position range is out of date and should
	be updated. The items in the given range retain the same identity.
	
	By using this update method users have to pass a payload object (any) for partial change.
	All payloads will be merged and then passed to #onBindHolder:at:payloads:"

	self
		assert: [ anObject isNotNil ]
		description: [ 'Payload must not be nil! For full update use #notifyItemsChanged:' ].
		
	self notifyWithEvent: (BlInfiniteDataSourceItemRangeChanged
		position: anInterval first
		itemCount: anInterval size
		payload: anObject)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyItemsInserted: anInterval [
	"Notify any registered observers that the currently reflected ===anInterval size===
	items starting at ===anInterval first=== have been newly inserted. The items
	previously located at ===anInterval first=== and beyond can now be found starting
	at position ===anInterval last===.
	This is a structural change event. Representations of other existing items in the
	data set are still considered up to date and will not be rebound, though their positions
	may be altered"

	self notifyWithEvent: (BlInfiniteDataSourceItemRangeInserted
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyItemsRemoved: anInterval [
	"Notify any registered event handlers that the ===anInterval size=== items previously
	located at ===anInterval first=== have been removed from the data set. The items
	previously located at and after ===anInterval last=== may now be found ===oldPosition - anInterval size===.
	This is a structural change event. Representations of other existing items in the data
	set are still considered up to date and will not be rebound, though their positions
 	may be altered."

	self notifyWithEvent: (BlInfiniteDataSourceItemRangeRemoved
		position: anInterval first
		itemCount: anInterval size)
]

{ #category : #'event firing' }
BlInfiniteDataSource >> notifyWithEvent: anEvent [
	"Fire a given event ensuring that it will happen in UI Thread"


	self flag: 'Find a solution'.

	BlUniverse default isUIProcess
		ifTrue: [ self fireEvent: anEvent ]
		ifFalse: [ self fireEvent: anEvent ]
]

{ #category : #hooks }
BlInfiniteDataSource >> onAttached: anInfiniteElement [
	"Is sent by InfiniteElement when it starts observing this DataSource"
]

{ #category : #'instance creation' }
BlInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Override to bind data to an element holder"
]

{ #category : #'instance creation' }
BlInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition payloads: aCollectionOfPayloads [
	"Override to bind data to an element holder"
	self onBindHolder: anElementHolder at: aPosition
]

{ #category : #'instance creation' }
BlInfiniteDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	"Override to create an ElementHolder for an item type.
	use ===BlElementHolder of: element=== to create a holder for an element".
	^ self subclassResponsibility
]

{ #category : #hooks }
BlInfiniteDataSource >> onDetached: anInfiniteElement [
	"Is sent by InfiniteElement when it stops observing this DataSource"
]

{ #category : #hooks }
BlInfiniteDataSource >> onElementAttached: anElementHolder [
	"Sent when an element created by this datasource has been attached to InfiniteElement.
	This can be used as a reasonable signal that the element is about to be seen by the user.
	If the datasource previously freed any resources in #onElementDetached: those resources should be restored here"
]

{ #category : #hooks }
BlInfiniteDataSource >> onElementDetached: anElementHolder [
	"Sent when an element created by this datasource has been detached from infinite element.
	Becoming detached is not necessarily a permanent condition;
	the consumer of the DataSource's elements may choose to cache elements offscreen while they
	are not visible, attaching and detaching them as appropriate"
]

{ #category : #hooks }
BlInfiniteDataSource >> onElementRecycled: anElementHolder [
	"Sent when an element created by this datasource has been recycled.
	An element is recycled when an InfiniteLayout decides that it no longer
	needs to be attached to InfiniteElement. This can be because it has
	fallen out of visibility or a set of cached elements represented by elements still
	attached to the parent InfiniteElement. If an item element has large or expensive data
	bound to it such as large bitmaps, this may be a good place to release those resources"
]
