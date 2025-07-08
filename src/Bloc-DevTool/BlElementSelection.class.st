"
I am a Halos element. For more information about me, see `BlDevHalosEventListener`.

"
Class {
	#name : #BlElementSelection,
	#superclass : #BlElement,
	#instVars : [
		'client',
		'clientListener',
		'dragOffset',
		'resizeButton',
		'removeButton',
		'inspectButton',
		'hasInformation',
		'marginElement',
		'paddingElement',
		'extentElement'
	],
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'instance creation' }
BlElementSelection class >> on: anElement [
	^ self new
		showOn: anElement;
		yourself
]

{ #category : #accessing }
BlElementSelection >> client [
	^ client
]

{ #category : #'showing / hiding' }
BlElementSelection >> close [
	self
		assert: [ client isNotNil ]
		description: [ 'I must have a client element' ].

	client removeEventHandler: clientListener.
	client := nil.
	self removeFromParent
]

{ #category : #initialization }
BlElementSelection >> defaultBorder [
	^ BlBorder paint: Color black width: 1
]

{ #category : #accessing }
BlElementSelection >> dragOffset [
	^ dragOffset
]

{ #category : #accessing }
BlElementSelection >> dragOffset: aPoint [
	dragOffset := aPoint
]

{ #category : #initialization }
BlElementSelection >> extraPadding [
	^ BlInsets all: 20
]

{ #category : #testing }
BlElementSelection >> hasInformation [
	^ hasInformation
]

{ #category : #actions }
BlElementSelection >> hideInfo [

	self padding: BlInsets empty.
	self position: self selectionPosition.
	self extent: self selectionExtent.
	
	self effect: BlNullEffect new.
	self background: self defaultBackground.
	self removeChild: marginElement.
	self removeChild: paddingElement.
	self removeChild: extentElement.
	hasInformation := false
]

{ #category : #initialization }
BlElementSelection >> initialize [
	super initialize.

	self initializeHandlers.
	self initializeActions.
	self initializeClientListener.
	self layout: BlFrameLayout new.

	self elevation: (BlGlobalElevation elevation: 1000).
	hasInformation := false
]

{ #category : #initialization }
BlElementSelection >> initializeActions [
	| initialPosition initialSize |

	removeButton := BlElementSelectionButton icon: BlEllipseGeometry new extent: 12@12.
	removeButton opacity: 0.75.
	removeButton background: Color red.
	removeButton border: (BlBorder builder width: 1; paint: Color black; build).
	
	inspectButton := BlElementSelectionButton icon: BlEllipseGeometry new  extent: 12@12.
	inspectButton opacity: 0.75.
	inspectButton background: Color blue.
	inspectButton border: (BlBorder builder width: 1; paint: Color black; build).
	
	resizeButton := BlElementSelectionButton icon: BlEllipseGeometry new extent: 12@12.
	resizeButton opacity: 0.75.
	resizeButton background: Color yellow.
	resizeButton border: (BlBorder builder width: 1; paint: Color black; build).

	removeButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		"we will close automatically"
		self client removeFromParent ]).

	resizeButton addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt |
		initialPosition := evt position.
		initialSize := self client extent.
		evt consume ]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEndEvent do: [ :evt |  evt consume.]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt |
		evt consume.
		self client extent: (initialSize + evt position - initialPosition) ]).

	inspectButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consume.
		self client inspect]).
	
	self addChild: removeButton.
	self addChild: inspectButton.
	self addChild: resizeButton
]

{ #category : #initialization }
BlElementSelection >> initializeClientListener [
	clientListener := BlElementSelectionListener on: self
]

{ #category : #initialization }
BlElementSelection >> initializeHandlers [

	self addEventHandler: (BlEventHandler
			 on: BlDoubleClickEvent
			 do: [ :anEvent |
				 anEvent consume.
				 self close ]).
	self addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 anEvent modifiers isShift ifTrue: [
					 anEvent consume.
					 self client hasParent ifTrue: [
						 BlElementSelection on: self client parent.
						 self close ] ] ]).
	self addEventHandler: (BlEventHandler
			 on: BlDragStartEvent
			 do: [ :anEvent |
				 | aClientOldGlobalPosition aClientNewGlobalPosition |
				 anEvent consume.

				 aClientOldGlobalPosition := self client positionInSpace.
				 aClientNewGlobalPosition := self space root globalPointToLocal:
					                             aClientOldGlobalPosition.
				 aClientNewGlobalPosition := aClientNewGlobalPosition.

				 "detach client from its current owner and attach it to the space root"
				 self client invalidate.
				 self client parent detachChild: self client.
				 self space root attachChild: self client.
				 self client position: aClientNewGlobalPosition.
				 self client invalidate.

				 "store drag start offset to allow us smooth dragging"
				 self dragOffset: anEvent position - aClientNewGlobalPosition ]).
	self addEventHandler: (BlEventHandler
			 on: BlDragEvent
			 do: [ :anEvent |
				 | aPosition |
				 anEvent consume.
				 aPosition := anEvent position - self dragOffset.
				 self client position: aPosition ])
]

{ #category : #layout }
BlElementSelection >> onLayout: aBounds context: aBlElementBoundsUpdater [
	super onLayout: aBounds context: aBlElementBoundsUpdater.

	"put remove button to the top left corner"
	removeButton position: 0@0 extent: removeButton extent context: aBlElementBoundsUpdater.

	"put inspect button to the bottom left corner"
	inspectButton position:  0@ (aBounds height - inspectButton height) extent: inspectButton extent context: aBlElementBoundsUpdater.

	"put resize button to the bottom right corner"
	resizeButton position: aBounds extent - (resizeButton width @ resizeButton height) extent: resizeButton extent context: aBlElementBoundsUpdater.
]

{ #category : #geometry }
BlElementSelection >> selectionExtent [

	^ (self padding expand: self client boundsInSpace) extent
]

{ #category : #geometry }
BlElementSelection >> selectionPosition [

	^ self client positionInSpace - self padding topLeft
]

{ #category : #accessing }
BlElementSelection >> show [
]

{ #category : #'showing / hiding' }
BlElementSelection >> showOn: anElement [
	"we don't want to add selection to the root element"

	anElement isRoot ifTrue: [ ^ self ].

	self
		assert: [ client isNil ]
		description: [ 'Can not assign selection to multiple elements!' ].

	self
		assert: [ self hasParent not ]
		description: [ 'I must not have parent' ].

	client := anElement.
	client addEventHandler: clientListener.
	client space root addChild: self.

	self position: self selectionPosition.
	self extent: self selectionExtent
]
