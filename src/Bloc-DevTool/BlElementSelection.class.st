"
I am a Halos element. For more information about me, see ${class:BlDevHalosEventListener}$.
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
		'infoButton',
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
	self relocate: self selectionPosition.
	self size: self selectionExtent.
	
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
	
	infoButton := BlElementSelectionButton icon: BlEllipseGeometry new extent: 12@12.
	infoButton opacity: 0.75.
	infoButton background: Color green.
	infoButton border: (BlBorder builder width: 1; paint: Color black; build).

	removeButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt |
		"we will close automatically"
		self client removeFromParent ]).

	resizeButton addEventHandler: (BlEventHandler on: BlDragStartEvent do: [ :evt |
		initialPosition := evt position.
		initialSize := self client extent.
		evt consumed: true ]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEndEvent do: [ :evt |  evt consumed: true.]).
	resizeButton addEventHandler: (BlEventHandler on: BlDragEvent do: [ :evt |
		evt consumed: true.
		self client size: (initialSize + evt position - initialPosition) ]).

	inspectButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self client inspect]).
	
	infoButton addEventHandler: (BlEventHandler on: BlClickEvent do: [ :evt | 
		evt consumed: true.
		self toggleInfo ]).
	
	self addChild: removeButton.
	self addChild: inspectButton.
	self addChild: infoButton.
	self addChild: resizeButton
]

{ #category : #initialization }
BlElementSelection >> initializeClientListener [
	clientListener := BlElementSelectionListener on: self
]

{ #category : #initialization }
BlElementSelection >> initializeHandlers [
	self
		addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :anEvent | 
					anEvent consumed: true.
					self close ]).
	self
		addEventHandler:
			(BlEventHandler
				on: BlClickEvent
				do: [ :anEvent |
					anEvent modifiers isShift ifTrue: [ 
						anEvent consumed: true.
						self client hasParent
							ifTrue: [
								BlElementSelection on: self client parent.
								self close ] ] ]).
	self
		addEventHandler:
			(BlEventHandler
				on: BlDragStartEvent
				do: [ :anEvent |
					| aClientOldGlobalPosition aClientNewGlobalPosition |
					anEvent consumed: true.
					
					aClientOldGlobalPosition := self client positionInSpace.
					aClientNewGlobalPosition := self space root globalPointToLocal: aClientOldGlobalPosition.
					aClientNewGlobalPosition := aClientNewGlobalPosition.
					
					"detach client from its current owner and attach it to the space root"
					self client invalidate.
					self client parent detachChild: self client.
					self space root attachChild: self client.
					self client relocate: aClientNewGlobalPosition.
					self client invalidate.
					
					"store drag start offset to allow us smooth dragging"
					self dragOffset: anEvent position - aClientNewGlobalPosition ]).
	self
		addEventHandler:
			(BlEventHandler
				on: BlDragEvent
				do: [ :anEvent | 
					| aPosition |
					anEvent consumed: true.
					aPosition := anEvent position - self dragOffset.
					self client relocate: aPosition ])
]

{ #category : #layout }
BlElementSelection >> onLayout: aBounds [
	super onLayout: aBounds.

	"put remove button to the top left corner"
	removeButton position: 0@0 extent: removeButton extent.

	"put inspect button to the bottom left corner"
	inspectButton position:  0@ (aBounds height - inspectButton height) extent: inspectButton extent.

	"put resize button to the bottom right corner"
	resizeButton position: aBounds extent - (resizeButton width @ resizeButton height) extent: resizeButton extent.
	
	"put info button to the top right corner"
	infoButton position: (aBounds width - resizeButton width) @ 0 extent: infoButton extent.
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

{ #category : #actions }
BlElementSelection >> showInfo [
	| extentTextElement |
	
	self padding: self client margin + self extraPadding.
	self relocate: self selectionPosition.
	self size: self selectionExtent.

	self effect: (BlGaussianShadowEffect new).
	self background: (Color white alpha: 0.5).
	
	marginElement := BlElement new.
	marginElement margin: self client margin negated.
	marginElement background: (Color red alpha: 0.5).
	marginElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	marginElement preventMouseEvents.
	marginElement effect: (BlClipOutInsetsEffect new insets: (self client margin)).

	paddingElement := BlElement new.
	paddingElement background: (Color blue alpha: 0.4).
	paddingElement border: (BlBorder paint: Color blue width: ((self client extent / 100.0) min max: self client border width)).
	paddingElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	paddingElement preventMouseEvents.
	paddingElement effect: (BlClipOutInsetsEffect new insets: (self client padding)).

	extentTextElement := BlTextElement new.
	extentTextElement padding: (BlInsets top: 2 right: 5 bottom: 2 left: 5).
	extentTextElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	extentTextElement text: (self client extent asString asRopedText).
	
	extentElement := BlScalableElement new.
	extentElement maxScale: 1.5.
	extentElement margin: self client padding.
	extentElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	extentElement contentElement: extentTextElement.

	self addChild: marginElement.
	self addChild: paddingElement.
	self addChild: extentElement.
	
	hasInformation := true
]

{ #category : #'showing / hiding' }
BlElementSelection >> showOn: anElement [

	"we don't want to add selection to the root element"
	anElement isRoot
		ifTrue: [ ^ self ].

	self
		assert: [ client isNil ]
		description: [ 'Can not assign selection to multiple elements!' ].

	self
		assert: [ self hasParent not ]
		description: [ 'I must not have parent' ].

	client := anElement.
	client addEventHandler: clientListener.
	client space root addChild: self.
	
	self relocate: self selectionPosition.
	self size: self selectionExtent.
]

{ #category : #actions }
BlElementSelection >> toggleInfo [
	self hasInformation
		ifTrue: [ self hideInfo ]
		ifFalse: [ self showInfo ]
]
