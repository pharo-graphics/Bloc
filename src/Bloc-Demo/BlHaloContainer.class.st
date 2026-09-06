"
I am an element that will contain and display Halos.

To make me appear, you need to do ""shift+alt+click"" on an element that is in a space with halos (i.e space that listens halos with a `BlSpaceHalosEventListener`).
You can then ""shift+alt+click"" on me to make me decorate the parent of my decorated element, I cannot show myself on the space root.
You can ""shift+alt+doubleClick"" to close me.

I am attached to the space root and my size and position depend on the element I 'decorate'.

I display some Halos around myself, each interacts in some way with my decorated element
"
Class {
	#name : #BlHaloContainer,
	#superclass : #BlElement,
	#instVars : [
		'decorated',
		'decoratedListener',
		'dragOffset',
		'spaceListener'
	],
	#category : #'Bloc-Demo-Halos'
}

{ #category : #'as yet unclassified' }
BlHaloContainer class >> exampleDisplayEventHandlersAsHalos [

	<script>
	| elt haloContainer |
	elt := BlElement new
		       background: Color lightRed;
		       clipChildren: false;
		       extent: 150 asPoint;
		       position: 100 asPoint.
	haloContainer := BlElement new
		                 background: Color lightGreen;
		                 layout: BlLinearLayout horizontal;
		                 constraintsDo: [ :c |
			                 c vertical fitContent.
			                 c horizontal fitContent.
			                 c padding: (BlInsets all: 5) ];
		                 position: 0 @ -30;
		                 clipChildren: false.

	elt addEventHandlerOn: BlDragEvent do: [ :e | 'drag' traceCr].

	elt addEventHandlerOn: BlDragEvent do: [ :e | elt inspect ].

	elt addEventHandlerOn: BlDragStartEvent do: [ :e | elt inspect ].

	elt addEventHandlerOn: BlClickEvent do: [ :event |
		(event modifiers isAlt and: event modifiers isShift) ifTrue: [
			(elt hasChild: haloContainer)
				ifFalse: [
					haloContainer removeChildren.
					elt eventDispatcher handlersDo: [ :handler |
						| handlerElt textElt |
						handlerElt := BlElement new
							              extent: 20 asPoint;
							              background: Color random;
							              clipChildren: false;
							              constraintsDo: [ :c |
								              c margin: (BlInsets all: 2) ].
						handlerElt
							addEventHandlerOn: BlClickEvent
							do: [ :e | handlerElt inspect ].
						textElt := BlTextElement new
							           text: handler action asText asRopedText;
							           background: Color lightYellow;
							           position: 0 @ 20.
						textElt text fontSize: 15.
						handlerElt
							addEventHandlerOn: BlMouseEnterEvent
							do: [ :e | handlerElt addChild: textElt ].
						handlerElt
							addEventHandlerOn: BlMouseLeaveEvent
							do: [ :e | handlerElt removeChild: textElt ].

						haloContainer addChild: handlerElt ].
					elt addChild: haloContainer ]
				ifTrue: [ elt removeChild: haloContainer ] ] ].



	elt openInSpace
]

{ #category : #'as yet unclassified' }
BlHaloContainer class >> exampleHalosAvailableAndCanDive [

	<script>
	| aContainer aSpace child |
	"shift+alt+click on the element shows the halo"
	"shift+click can make the halos dive to the parent on the decorated element"
	aContainer := BlElement new
		              background: Color lightRed;
		              extent: 300 asPoint;
		              position: 50 asPoint.
	child := BlElement new
		         background: Color lightBlue;
		         extent: 100 asPoint;
		         position: 10 asPoint.

	aContainer addChild: child.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.
	aSpace addHalosListenerNewPrototype.


	aSpace show
]

{ #category : #examples }
BlHaloContainer class >> exampleHalosDisplayedAboveWithFrameLayout [
	"This basic example simply tries to display children around an element using a FrameLayout and playing with margins to display them around the element and not 'inside'.
	The example doesn't use the BlHaloContainer class"
	
	<script>
	| container elt1 elt2 elt3 elements marginOffset |
	container := BlElement new
		             extent: 100 asPoint;
		             position: 100 asPoint;
		             background: Color lightRed;
		             layout: BlFrameLayout new;
		             clipChildren: false.

	elt1 := BlElement new
		        extent: 20 asPoint;
		        background: Color lightBlue.
	elt2 := BlElement new
		        extent: 20 asPoint;
		        background: Color lightGreen.
	elt3 := BlElement new
		        extent: 20 asPoint;
		        background: Color lightOrange.

	elements := {
		            elt1.
		            elt2.
		            elt3 }.

	marginOffset := 2.

	elt1 constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignLeft ].
	elt2 constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignRight ].
	elt3 constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignCenter ].

	elt1 whenLayoutedDoOnce: [
		elt1 margin: (BlInsets all: 0 - (elt1 width + marginOffset)) ].
	elt2 whenLayoutedDoOnce: [
		elt2 margin: (BlInsets all: 0 - (elt2 width + marginOffset)) ].
	elt3 whenLayoutedDoOnce: [
		elt3 margin: (BlInsets all: 0 - (elt3 width + marginOffset)) ].

	container addChildren: elements.

	container openInSpace
]

{ #category : #'instance creation' }
BlHaloContainer class >> on: anElement [
	^ self new
		showOn: anElement;
		yourself
]

{ #category : #'instance creation' }
BlHaloContainer class >> on: anElement in: aSpaceHalosEventListener [

	^ self new
		  showOn: anElement;
		  spaceListener: aSpaceHalosEventListener;
		  yourself
]

{ #category : #'showing / hiding' }
BlHaloContainer >> close [

	self
		assert: [ decorated isNotNil ]
		description: [ 'I must have a client element' ].

	decorated removeEventHandler: decoratedListener.
	decorated := nil.
	self spaceListener removeHaloContainer.
	self removeFromParent
]

{ #category : #accessing }
BlHaloContainer >> decorated [
	^ decorated
]

{ #category : #initialization }
BlHaloContainer >> defaultBorder [

	^ BlBorderBuilder new paint: (Color gray alpha: 0.5); width: 2; dashed; build.
]

{ #category : #accessing }
BlHaloContainer >> dragOffset [
	^ dragOffset
]

{ #category : #accessing }
BlHaloContainer >> dragOffset: aPoint [
	dragOffset := aPoint
]

{ #category : #initialization }
BlHaloContainer >> initialize [

	super initialize.
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self border: self defaultBorder.

	self initializeHandlers.
	self initializeHalos.
	self initializeDecoratedListener.


	self zIndex: 1000
]

{ #category : #initialization }
BlHaloContainer >> initializeDecoratedListener [

	decoratedListener := BlHaloContainerListener on: self
]

{ #category : #initialization }
BlHaloContainer >> initializeEventHandlerClosing [ 

		self addEventHandler: (BlEventHandler
			 on: BlDoubleClickEvent
			 do: [ :anEvent |
				 anEvent consume.
				 self close ]).
]

{ #category : #initialization }
BlHaloContainer >> initializeEventHandlerDive [

	self addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 (anEvent modifiers isShift and: [ anEvent primaryButtonPressed ]) ifTrue: [
					 anEvent consume.
					 self decorated hasParent ifTrue: [
						 self decorated parent = self space root ifFalse: [
							 self class on: self decorated parent in: spaceListener ].
						 self close ] ] ])
]

{ #category : #initialization }
BlHaloContainer >> initializeEventHandlerDrag [ 

	self addEventHandler: (BlEventHandler
			 on: BlDragStartEvent
			 do: [ :anEvent |
				 | aClientOldGlobalPosition aClientNewGlobalPosition |
				 anEvent consume.

				 aClientOldGlobalPosition := self decorated positionInSpace.
				 aClientNewGlobalPosition := self space root globalPointToLocal:
					                             aClientOldGlobalPosition.

				 "detach client from its current owner and attach it to the space root"
				 self decorated invalidate.
				 self decorated parent detachChild: self decorated.
				 self space root attachChild: self decorated.
				 self decorated position: aClientNewGlobalPosition.
				 self decorated invalidate.

				 "store drag start offset to allow us smooth dragging"
				 self dragOffset: anEvent position - aClientNewGlobalPosition ]).
	self addEventHandler: (BlEventHandler
			 on: BlDragEvent
			 do: [ :anEvent |
				 | aPosition |
				 anEvent consume.
				 aPosition := anEvent position - self dragOffset.
				 self decorated position: aPosition ])
]

{ #category : #initialization }
BlHaloContainer >> initializeHaloDelete [

	| deleteHalo |
	deleteHalo := BlHalo delete.


	deleteHalo container: self.
	self addChild: deleteHalo
]

{ #category : #initialization }
BlHaloContainer >> initializeHaloInspect [

	| inspectHalo |
	inspectHalo := BlHalo inspect.
	
	
	inspectHalo container: self.
	self addChild: inspectHalo
]

{ #category : #initialization }
BlHaloContainer >> initializeHaloResize [

	| resizeHalo |
	resizeHalo := BlHalo resize.

	resizeHalo container: self.
	self addChild: resizeHalo
]

{ #category : #initialization }
BlHaloContainer >> initializeHalos [

	self initializeHaloDelete.
	self initializeHaloInspect.
	self initializeHaloResize.
]

{ #category : #initialization }
BlHaloContainer >> initializeHandlers [

	self initializeEventHandlerClosing.
	self initializeEventHandlerDive.
	"self initializeEventHandlerDrag"
]

{ #category : #geometry }
BlHaloContainer >> selectionExtent [

	^ (self padding expand: self decorated boundsInSpace) extent
]

{ #category : #geometry }
BlHaloContainer >> selectionPosition [

	^ self decorated positionInSpace - self padding topLeft
]

{ #category : #accessing }
BlHaloContainer >> show [
]

{ #category : #'showing / hiding' }
BlHaloContainer >> showOn: anElement [
	"we don't want to add selection to the root element"

	anElement isRoot ifTrue: [ ^ self ].

	self
		assert: [ decorated isNil ]
		description: [ 'Can not assign selection to multiple elements!' ].

	self
		assert: [ self hasParent not ]
		description: [ 'I must not have parent' ].

	decorated := anElement.
	decorated addEventHandler: decoratedListener.
	decorated space root addChild: self.

	self position: self selectionPosition.
	self extent: self selectionExtent.
]

{ #category : #accessing }
BlHaloContainer >> spaceListener [ 

	^ spaceListener 
]

{ #category : #accessing }
BlHaloContainer >> spaceListener: aSpaceHalosEventListener [

	spaceListener := aSpaceHalosEventListener 
]
