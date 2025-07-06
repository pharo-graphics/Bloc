"
I'm a replacement for `BlSpace`. The idea is to simplify and to remove complex  computations that are implemented in `BlSpace`. 
For now
- I don't use layout resizing propagation rules at all (compare `BlSpace>>#doStyle` and `ToSpace>>#doStyle`)

- I bring a different toplevel structure. I'm made of a `layerHolder` with owns all top level holders which are layouted on top of each other, with the same extent (`rootLayer`, `contextMenuLayer` and `popupLayer`) 

## Comments from `BlSpace`
I am the logical representation of a window in Bloc regardless of the current Host in use.
Here are some of the important objects I use and talk to:
- `BlTime`
- Various `BlBaseEventProcessor` subclasses broker `BlEvent` types
- `BlSpaceFrame`

## Gracefully closing the image when a space is closed
A common use case is to quit the application when some particular space is closed. To do this, we provide `BlSpaceShutdownOnCloseListener` which can be added to any space as an event handler. It listens for a `BlSpaceClosedEvent`, which is sent after a space is closed. See the listener class for configuration options.

"
Class {
	#name : #BlSpace,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlSpaceProperties + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlSpaceProperties classTrait + TBlDebug classTrait',
	#instVars : [
		'host',
		'hostSpace',
		'extent',
		'position',
		'resizable',
		'borderless',
		'eventDispatcher',
		'eventListener',
		'mouseProcessor',
		'focusProcessor',
		'keyboardProcessor',
		'focusChain',
		'pulseRequested',
		'currentCursor',
		'session',
		'focused',
		'title',
		'fullscreen',
		'fullsize',
		'layoutError',
		'tasks',
		'time',
		'frame',
		'elementsNeedingPaint',
		'elementsNeedingLayout',
		'reference',
		'iconStencil',
		'rootElement',
		'userData',
		'previousVisibleStatus'
	],
	#category : #'Bloc-Space'
}

{ #category : #'private - change' }
BlSpace class >> extractRoots: aSetOfElements [
	| roots |
	" feenk version 2022-02-01 that eliminate recursion from allParentsDo: "
	
	roots := IdentitySet withAll: aSetOfElements.
	aSetOfElements
		do:
			[ :each | 
			| current |
			current := each parent.
			[ current isNil ]
				whileFalse:
					[ (roots includes: current)
						ifTrue:
							[ roots remove: each ifAbsent: [  ].
							current := nil ]
						ifFalse: [ current := current parent ] ] ].
	^ roots
]

{ #category : #'debug - simulation' }
BlSpace class >> locationInside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := theBounds atRandom.
		
	self
		assert: [ theBounds containsPoint: aPosition ]
		description: [ 'Point({1}) must be inside of the bounds({2})' format: { aPosition . theBounds } ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlSpace class >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height asInteger atRandom).
		theBounds bottomLeft + (theBounds width asInteger atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height asInteger atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	"Wait until a BlSpace doesn't have available tasks to execute. 
	
	Inspired on BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| deadline |
	deadline := aSpace time now + aDuration.
	
	aSpace time
		every: 5 milliSeconds
		while: [
			aSpace universe hasDeferredActions or: [
				(aSpace taskQueue isEmpty or: [
					aSpace time now >= deadline ]) not ] ]
		do: [
			"We delegate to the host class also to run a cycle, it is needed when using morphic host, as this can run in the same UI thread blocking everything."
			aSpace host runOneCycle. 
			aSpace pulse ].

	aSpace pulse.

	^ aSpace taskQueue isEmpty
]

{ #category : #'debug - simulation' }
BlSpace class >> pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace timeout: aDuration [
	"Wait until a BlSpace doesn't have available tasks to execute. 
	
	Inspired on BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| deadline |
	deadline := aSpace time now + aDuration.

	"A non-opened space needs a special wait."
	aSpace isOpened ifFalse: [
		| aSemaphore |
		aSemaphore := Semaphore new.
		aSpace
			addEventHandlerOn: BlSpaceShownEvent
			doOnce: [ :event | aSemaphore signal ].
		aSemaphore wait: aDuration ].

	^ self pulseUntilEmptyTaskQueue: aSpace timeout: aDuration
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	^ self simulateClickOn: anElement button: BlMouseButton primary
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence."

	| aPosition |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			(BlMouseDownEvent button: aButton) position: aPosition; yourself.
			(BlMouseUpEvent button: aButton) position: aPosition; yourself }
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateClickOutside: anElement [
	"Simulate a click event in outside of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition |
	aPosition := self locationOutside: anElement.
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	"Simulate a double click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	"we simulate a double click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"

	| aPosition aDelta |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	aDelta :=
		(anElement localBoundsToGlobal:
			(BlBounds origin: 0.0 @ 0.0 extent: aBlVector)) extent.

	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
				(BlMouseDownEvent primary
					 position: aPosition;
					 yourself).
				(BlMouseMoveEvent primary
					 position: aPosition + aDelta;
					 delta: aDelta;
					 yourself).
				(BlMouseUpEvent primary
					 position: aPosition + aDelta;
					 yourself) }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	"Simulate a drag in the center of a given element by
	performing mouse down, mouse move, and mouse up events."

	| aPosition aDelta |
	anElement forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvent:
			(BlMouseDownEvent primary
				position: aPosition;
				yourself)
		on: anElement.

	aSequenceOfBlVectors do: [ :each |
		aDelta := (anElement localBoundsToGlobal:
			(BlBounds origin: 0.0@0.0 extent: each)) extent.
		aPosition := aPosition + aDelta.
		self
			simulateEvent:
				(BlMouseMoveEvent primary
					position: aPosition "+ aDelta";
					delta: aDelta;
					yourself)
			on: anElement ].

	self
		simulateEvent:
			(BlMouseUpEvent primary
				position: aPosition "+ aDelta";
				delta: aDelta;
				yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	a sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordinates of the provided element"

	| aSpace topMostElement |
	anElement isAttachedToSceneGraph
		ifTrue: [ aSpace := anElement space ]
		ifFalse: [
			topMostElement := anElement topMostParent.
			aSpace := self new.
			aSpace root addChild: topMostElement ].

	aCollectionOfEvents do: [ :anEvent |
		anEvent fillFromTime: aSpace time ].

	aSpace pulse.
	aSpace
		dispatchTimeEvent: BlSpaceEventsProcessedEvent
		during: [
			aCollectionOfEvents do: [ :anEvent |
				aSpace dispatchEvent: anEvent ] ].
	aSpace pulse.

	topMostElement ifNotNil: [ topMostElement removeFromParent ]
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	"Simulate a key down event"

	self
		simulateEvents: { BlKeyDownEvent new key: aKeyboardKey; yourself }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	"Simulate a key up event"

	self
		simulateEvents: { BlKeyUpEvent new key: aKeyboardKey; yourself }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	"Simulate a mouse down event in the middle of a given element"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvents: { BlMouseDownEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	"Simulate a mouse down event at a given location in the space of the element"

	self
		simulateEvents: { BlMouseDownEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	aPosition := self locationInside: anElement.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPoint }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	"Simulate a mouse move event at a given location in the space of the element"
	
	self
		simulateEvents: { BlMouseMoveEvent primary
			position: aToPoint;
			delta: (aToPoint - aFromPoint)  }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	"Simulate a mouse move event at a random location outside of element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	aPosition := self locationOutside: anElement.
	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	"Simulate a mouse up event in the middle of a given element"

	| aPosition |
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.

	self
		simulateEvent:
			(BlMouseUpEvent primary
				 position: aPosition;
				 yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	"Simulate a mouse up event at a given location in the space of the element"

	self
		simulateEvent:
			(BlMouseUpEvent primary
				 position: aPoint;
				 yourself)
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	"Simulate a mouse wheel event in the middle of a given element"
	| aPosition aBlocEvent |

	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"Bloc event"
	aBlocEvent := BlMouseWheelEvent new
		isTouch: false;
		vector: aBlVector asBlocVector;
		position: aPosition.
	
	self
		simulateEvent: aBlocEvent
		on: anElement.
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	"Simulate a secondary click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	
	^ self simulateClickOn: anElement button: BlMouseButton secondary
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [

	self
		simulateEvent: (BlTextInputEvent new
				 text: aString;
				 yourself)
		on: aBlElement
]

{ #category : #accessing }
BlSpace >> asReference [
	<return: #BlSpaceReference>

	^ reference ifNil: [ reference := BlAttachedCachedSpaceReference forSpace: self ]
]

{ #category : #'api - displaying' }
BlSpace >> becomeVisible [
	"Notify root element that it is now visible to the user"
	self root space: self

]

{ #category : #'window - properties' }
BlSpace >> borderless: aBoolean [

	borderless := aBoolean.
	self hostSpaceDo: [ :aHostSpace | aHostSpace borderless: aBoolean ]
]

{ #category : #accessing }
BlSpace >> bounds [

	^ BlBounds origin: self position extent: self extent
]

{ #category : #'api - displaying' }
BlSpace >> center [
	"Tell host to change my position to be centered. Do nothing if host space is not present (e.g. not shown)."

	self hostSpace ifNotNil: [ :hw | hw center ]
]

{ #category : #'change - rendering' }
BlSpace >> clearDirtyElements [
	"Clear dirty elements collection, which means there are no pending graphic operations."

	elementsNeedingPaint removeAll
]

{ #category : #'api - displaying' }
BlSpace >> close [
	"Request closing this space. This might happen in a host process (async). 
	This space can be reopened via `show`, either with current host or with another host."
	
	host universe closeSpace: self
]

{ #category : #'cursor managing' }
BlSpace >> currentCursor [
	^ currentCursor 
]

{ #category : #'cursor managing' }
BlSpace >> currentCursor: aCursor [

	currentCursor := aCursor.
	currentCursor ifNil: [ ^ self updateCursor: Cursor normal ].
	self updateCursor: aCursor
]

{ #category : #'change - rendering' }
BlSpace >> damagedRectangle [

	| bounds |
	elementsNeedingPaint do: [ :each |
		bounds
			ifNil: [ bounds := each damagedBoundsInSpace copy ]
			ifNotNil: [ bounds merge: each damagedBoundsInSpace ] ].

	^ bounds expand
]

{ #category : #'change - rendering' }
BlSpace >> damagedRectangles [

	^ elementsNeedingPaint
		  collect: [ :each | each damagedBoundsInSpace ]
		  as: Array
]

{ #category : #initialization }
BlSpace >> defaultEventDispatcher [
	^ BlDirectEventDispatcher on: self
]

{ #category : #initialization }
BlSpace >> defaultEventListener [

	^ BlSpaceEventListener space: self
]

{ #category : #initialization }
BlSpace >> defaultExtent [
	^ 800@600
]

{ #category : #initialization }
BlSpace >> defaultRoot [

	^ BlElement new
		  background: self defaultRootBackground;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  elevation: (BlRelativeElevation elevation: self defaultRootElevation);
		  labeled: self defaultRootLabel;
		  yourself
]

{ #category : #initialization }
BlSpace >> defaultRootBackground [
	^ Color white
]

{ #category : #initialization }
BlSpace >> defaultRootElevation [

	^ 0
]

{ #category : #initialization }
BlSpace >> defaultRootLabel [
	^ #'space-root'
]

{ #category : #initialization }
BlSpace >> defaultTitle [
	^ ''
]

{ #category : #'window - properties' }
BlSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"


	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace densityDpi ]
		"Without an actual window we can only guess"
		ifAbsent: [ 96.0 ]
]

{ #category : #'api - tasks' }
BlSpace >> dequeueTask: aBlTask [
	self taskQueue dequeue: aBlTask.
	self requestNextPulse
]

{ #category : #'children dispatching' }
BlSpace >> dispatchAddedToSceneGraph [
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self root dispatchAddedToSceneGraph

]

{ #category : #'event handling' }
BlSpace >> dispatchEventWithTimestamp: aBlEvent [ 

	aBlEvent hasTimestamp ifFalse: [ aBlEvent fillFromTime: self time ].
	self dispatchEvent: aBlEvent
]

{ #category : #'children dispatching' }
BlSpace >> dispatchRemovedFromSceneGraph [
	"Sent after topFrame was removed from scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self root dispatchRemovedFromSceneGraph
]

{ #category : #pulse }
BlSpace >> dispatchTimeEvent: aSpacePhaseEventClass during: aBlock [

	| aStartTime |
	aStartTime := self time nowInUTCMicroseconds.
	aBlock value.
	self dispatchEvent: (aSpacePhaseEventClass new
			 startMicroseconds: aStartTime
			 endMicroseconds: self time nowInUTCMicroseconds;
			 yourself)
]

{ #category : #'change - layout' }
BlSpace >> doLayout [

	self isLayoutRequested ifFalse: [ ^ self ].

	[
	| layoutCounter maxLayoutCount |
	layoutCounter := 0.
	maxLayoutCount := 100.

	[
	self hasLayoutError not and: [
		self isLayoutRequested and: [ layoutCounter < maxLayoutCount ] ] ]
		whileTrue: [
			self doUpdateLayout.
			layoutCounter := layoutCounter + 1.
			layoutCounter = 50 ifTrue: [
				'Warning: Layout was performed 50 times per frame!' traceCr ] ].

	self root dispatchLayoutDone

	"I prevent infinite spawn of debuggers" ]
		on: Error
		do: [ :anError |
			layoutError := anError.
			[ layoutError debug ] ensure: [ layoutError := nil ] ]
]

{ #category : #'focus managing' }
BlSpace >> doUpdateFocus [

	(self focusOwner notNil and: [
		self focusOwner isAttachedToSceneGraph not ]) ifTrue: [
		focusChain
			deepestAttachedElementDo: [ :aNewFocusOwner |
				aNewFocusOwner requestFocusDueToRemoval: true ]
			ifAbsent: [ self focusProcessor focusOwner: nil ] ].

	self focusOwner ifNil: [ self initializeFocus ]
]

{ #category : #'change - layout' }
BlSpace >> doUpdateLayout [

	| elementsToLayout aBlElementBoundsUpdater |
	elementsNeedingLayout copy do: [ :eachElement |
		eachElement privatePreviousMeasurementSpec ifNil: [
			elementsNeedingLayout remove: eachElement.
			eachElement requestLayout ] ].

	elementsToLayout := elementsNeedingLayout reject: [ :eachElement |
		                    | shouldIgnore |
		                    shouldIgnore := false.

		                    elementsNeedingLayout do: [ :eachPotentialParent |
			                    (eachElement allParentsInclude:
				                     eachPotentialParent) ifTrue: [
				                    eachElement
					                    allParentsUpTo: eachPotentialParent
					                    do: [ :eachParent |
					                    eachParent privateRequestingLayout: true ].
				                    shouldIgnore := true ] ].

		                    shouldIgnore ].

	"we should clear the elements needing layout before we compute layout
	to support multiple layout passes"
	elementsNeedingLayout removeAll.

	elementsToLayout := elementsToLayout
		                    collect: [ :eachElement |
		                    eachElement -> eachElement compositionDepth ]
		                    as: Array.
	elementsToLayout := (elementsToLayout sort: [ :a :b |
		                     a value > b value ]) collect: [ :each |
		                    each key ].

	aBlElementBoundsUpdater := BlElementBoundsUpdater new.

	elementsToLayout do: [ :eachElement |
		self
			doUpdateLayoutBoundary: eachElement
			context: aBlElementBoundsUpdater ].

	self root isLayoutRequested ifTrue: [
		self doUpdateLayout: self root context: aBlElementBoundsUpdater ].

	aBlElementBoundsUpdater commitChanges
]

{ #category : #'change - layout' }
BlSpace >> doUpdateLayout: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	| currentExtent |
	"First, we measure..."
	currentExtent := self extent.
	anElement measure: (BlExtentMeasurementSpec
		widthSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent x)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent)
		heightSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec exact: currentExtent y)
			usedSize:  0.0
			resizer: BlLayoutResizer matchParent)).

	"...then, we layout in measured during previous step bounds"
	anElement
		applyLayoutIn: anElement measuredBounds asRectangle
		context: aBlElementBoundsUpdater

]

{ #category : #'change - layout' }
BlSpace >> doUpdateLayoutBoundary: anElement context: aBlElementBoundsUpdater [
	"Perform layout of a given element (e.g. root or glass)"

	"first we measure.."
	anElement measure: anElement privatePreviousMeasurementSpec.
				
	"...then we layout in measured during previous step bounds"
	anElement
		applyLayoutIn: (anElement position extent: anElement measuredExtent)
		context: aBlElementBoundsUpdater
]

{ #category : #'change - layout' }
BlSpace >> elementsNeedingLayout [

	^ elementsNeedingLayout
]

{ #category : #'change - rendering' }
BlSpace >> elementsNeedingPaint [

	^ elementsNeedingPaint
]

{ #category : #'api - tasks' }
BlSpace >> enqueueTask: aBlTask [
	aBlTask onEnqueued: self.
	self taskQueue enqueue: aBlTask.
	self requestNextPulse
]

{ #category : #'api - tasks' }
BlSpace >> enqueueTasksFrom: aTaskQueue [

	aTaskQueue isEmpty ifTrue: [ ^ self ].
	aTaskQueue tasks do: [ :eachTask | eachTask onEnqueued: self ].	
	self taskQueue enqueueFrom: aTaskQueue.
	self requestNextPulse
]

{ #category : #pulse }
BlSpace >> ensureSession [
	"Check current session and perform required operations if it changed since last frame"

	session == Smalltalk session
		ifTrue: [ ^ self ].

	self onSessionChanged: Smalltalk session
]

{ #category : #'private - display' }
BlSpace >> ensureWindowOpen [

	hostSpace ifNotNil: [
		hostSpace isValid ifFalse: [
			self setUpHostSpace.
			previousVisibleStatus ifTrue: [ hostSpace open ] ] ]
]

{ #category : #'event management accessing' }
BlSpace >> eventDispatcher [
	^ eventDispatcher
]

{ #category : #accessing }
BlSpace >> eventListener [

	^ eventListener
]

{ #category : #accessing }
BlSpace >> eventListener: anEventListener [

	eventListener := anEventListener
]

{ #category : #'window - properties' }
BlSpace >> extent [
	<return: #Point>

	^ self windowExtent
]

{ #category : #'window - properties' }
BlSpace >> extent: aNewExtent [
	self windowExtent: aNewExtent
]

{ #category : #'private - change' }
BlSpace >> extractRoots: aSetOfElements [
	^ self class extractRoots: aSetOfElements
]

{ #category : #'event handling' }
BlSpace >> findMouseEventTargetAt: aPoint [

	"Return the deepest child element starting from root that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"

	<return: #BlElement or: nil>
	^ self root findMouseEventTargetAt: aPoint
]

{ #category : #'focus managing' }
BlSpace >> focusOwner [
	<return: #BlElement>

	^ focusChain ifNotNil: [ :aFocusChain | aFocusChain last ]
]

{ #category : #'focus managing' }
BlSpace >> focusOwner: anElement [

	self focusOwner = anElement ifTrue: [ ^ self ].
	focusChain := anElement ifNotNil: [ BlFocusChain of: anElement ].
]

{ #category : #'accessing - processors' }
BlSpace >> focusProcessor [

	^ focusProcessor
]

{ #category : #'accessing - processors' }
BlSpace >> focusProcessor: aFocusProcessor [
	focusProcessor := aFocusProcessor
]

{ #category : #'window - properties' }
BlSpace >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
BlSpace >> frame [
	<return: #BlSpaceFrame>

	^ frame
]

{ #category : #'window - properties' }
BlSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	fullscreen := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullscreen: aBoolean ]
]

{ #category : #'window - properties' }
BlSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	fullsize := aBoolean.
	 self hostSpaceDo: [ :aHostSpace | aHostSpace fullsize: aBoolean ]
]

{ #category : #'focus managing' }
BlSpace >> grabFocus [

	self focused: true
]

{ #category : #'change - rendering' }
BlSpace >> hasDirtyElements [

	^ elementsNeedingPaint notEmpty
]

{ #category : #'focus managing' }
BlSpace >> hasFocus: anElement [
	"Return true if a given element is within the focus chain"

	self focusOwner ifNil: [ ^ false ].

	self focusOwner == anElement ifTrue: [ ^ true ].

	^ self focusOwner allParentsInclude: anElement
]

{ #category : #'host space - accessing' }
BlSpace >> hasHostSpace [
	"Return true if I have a host space, false otherwise"

	^ self hostSpace isNotNil
]

{ #category : #testing }
BlSpace >> hasInParentChain: anElement [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/715'.

	^ anElement = self
]

{ #category : #testing }
BlSpace >> hasLayoutError [
	"Return true if there was a layout error, false otherwise"

	^ layoutError isNotNil
]

{ #category : #testing }
BlSpace >> hasOwner [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/715'.
	
	^ false
]

{ #category : #testing }
BlSpace >> hasParent: anElement [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/715'.

	^ false
]

{ #category : #'window - properties' }
BlSpace >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #'api - displaying' }
BlSpace >> hide [
	self hostSpace ifNotNil: [ :hw | hw hide ]
]

{ #category : #'host space - accessing' }
BlSpace >> host [
	^ host
]

{ #category : #'host space - accessing' }
BlSpace >> host: aHost [
	"Change the host of this space. Asynchronous. If the space is opened, first destroy the host window and then open the space with a new host"

	self isOpened
		ifFalse: [ host := aHost ]
		ifTrue: [
			self
				addEventHandlerOn: BlSpaceDetachedEvent
				doOnce: [
					host := aHost.
					self universe attachSpace: self ].

			self universe detachSpace: self ]
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpace [
	^ hostSpace
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpace: aHostSpace [
	"Assign a host space window that will be a source of UI events
	and will provide a rendering surface on which I will be rendered.
	aHostSpace must not be nil"


	hostSpace := aHostSpace.
	self hostSpaceChanged.
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpaceChanged [
	"When host space changed we might want to adapt sizes"
	self windowExtent: self windowExtent.
	"host space changed => renderer changed, we want to redraw the whole space"
	self invalidateAll
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpaceDo: aBlock [
	^ self hostSpaceDo: aBlock ifAbsent: [ self ]
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpaceDo: aBlock ifAbsent: anAbsentBlock [

	self hasHostSpace ifFalse: [ ^ anAbsentBlock value ].

	self hostSpace isValid ifFalse: [ ^ anAbsentBlock value ].

	^ aBlock cull: self hostSpace
]

{ #category : #'window - properties' }
BlSpace >> icon [
	"Return an object that understands #asElement, or nil"
	^ iconStencil
]

{ #category : #'window - properties' }
BlSpace >> icon: aStencil [
	"aStencil is an object that undestands #asElement and returns ${class:BlElement}$"
	
	iconStencil = aStencil ifTrue: [ ^ self ].
	
	iconStencil := aStencil.
	
	self fireEvent: (BlSpaceIconChangedEvent new iconStencil: aStencil)
]

{ #category : #initialization }
BlSpace >> initialize [

	super initialize.

	host := BlHost pickHost.
	pulseRequested := true.
	session := Smalltalk session.
	elementsNeedingPaint := Set new.
	elementsNeedingLayout := Set new.

	tasks := BlSpaceTaskQueue space: self.
	time := BlTime real.
	frame := BlSpaceFrame new.

	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	eventDispatcher addEventFilter: eventListener.

	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.

	rootElement := self defaultRoot.

	self extent: self defaultExtent.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self fullsize: false.
	self title: self defaultTitle.
	self focused: false.

	self currentCursor: Cursor normal.

	self root space: self
]

{ #category : #'focus managing' }
BlSpace >> initializeFocus [
	self root isFocusable
		ifTrue: [ self root requestFocus ]
]

{ #category : #'-- extensions-spec2 --' }
BlSpace >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ self root inspectionPreview: aBuilder
]

{ #category : #'-- extensions-spec2 --' }
BlSpace >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ self root inspectionTree: aBuilder
]

{ #category : #'change - rendering' }
BlSpace >> invalidRect: aBlBounds from: anElement [

	self flag: #todo. "aBlBounds is ignored. Rename selector!"
	elementsNeedingPaint add: anElement.
	self requestHostSpaceRedraw.
	self requestNextPulse
]

{ #category : #'change - rendering' }
BlSpace >> invalidateAll [

	"Always mark root"
	self markNeedsPaint: self root from: self root.

	"Also recursively any child in a layer"
	self root allChildrenBreadthFirstDo: [ :each |
		each wantsSeparateCompositingLayer ifTrue: [ 
			self markNeedsPaint: each from: each ] ]
]

{ #category : #'window - properties' }
BlSpace >> isBorderless [

	^ self
		  hostSpaceDo: [ :aHostSpace | aHostSpace borderless ]
		  ifAbsent: [ borderless ]
]

{ #category : #'window - properties' }
BlSpace >> isFocused [

	^ focused
]

{ #category : #'window - properties' }
BlSpace >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise."

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace isFullscreen ]
		ifAbsent: [ fullscreen ]
]

{ #category : #'window - properties' }
BlSpace >> isFullsize [
	"Return true if an underlying window is in fullsize mode, false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent and has no window title."

	^ self 
		hostSpaceDo: [ :aHostSpace | aHostSpace fullsize ]
		ifAbsent: [ fullsize ]
]

{ #category : #'change - layout' }
BlSpace >> isLayoutRequested [
	"Indicates whether or not root element's layout needs to be updated next frame"
	
	^ self root isLayoutRequested or: [ self elementsNeedingLayout isNotEmpty ]
]

{ #category : #testing }
BlSpace >> isOpened [
	"Return true if the space was shown (by sending #show message), false otherwise.
	Please note, that an opened space can be hidden which does not influence the result of #isOpened"

	^ (self host class hasUniverse)
		and: [ self universe hasSpace: self ]
]

{ #category : #pulse }
BlSpace >> isPulseRequested [
	"Return true if space pulse was requested, false otherwise"

	^ pulseRequested
]

{ #category : #'window - properties' }
BlSpace >> isResizable [
	"Return true if underlying window is resizable, false otherwise"

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace isResizable ]
		ifAbsent: [ resizable ]
]

{ #category : #'host space - text input' }
BlSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"

	^ self hostSpaceDo: [:hs | hs isTextInputActive] ifAbsent: [ false ]
]

{ #category : #testing }
BlSpace >> isVisible [
	^ self hasHostSpace
		ifTrue: [ self hostSpace isVisible ]
		ifFalse: [ false ]
]

{ #category : #'accessing - processors' }
BlSpace >> keyboardProcessor [

	^ keyboardProcessor
]

{ #category : #'accessing - processors' }
BlSpace >> keyboardProcessor: aKeyboardProcessor [
	keyboardProcessor := aKeyboardProcessor
]

{ #category : #'window - properties' }
BlSpace >> knowsPosition [
	"Return true if this space knows its position.
	By default, spaces don't know their position and allow the window manager to choose one.
	Setting an explicit position during space creation will result in a window created at a specified position"

	^ position notNil
]

{ #category : #'focus managing' }
BlSpace >> loseFocusFor: anElement [
	self focusProcessor loseFor: anElement
]

{ #category : #'change - rendering' }
BlSpace >> markNeedsCompositionPaint: anElement from: aSourceElement [
	
	self flag: #todo.
	self markNeedsPaint: anElement from: aSourceElement
]

{ #category : #'change - rendering' }
BlSpace >> markNeedsPaint: anElement from: aSourceElement [

	elementsNeedingPaint add: aSourceElement.
	self requestHostSpaceRedraw.
	self requestNextPulse
]

{ #category : #'api - displaying' }
BlSpace >> maximize [
	self hostSpace ifNotNil: [ :hw | hw maximize ]
]

{ #category : #'api - displaying' }
BlSpace >> maximized [
	self hostSpace ifNotNil: [ :hw | ^ hw maximized ].
	^ false
]

{ #category : #dispatch }
BlSpace >> measureTextParagraph: aBlTextParagraph [

	self
		hostSpaceDo: [ :aHostSpace | 
			aHostSpace renderer isValid ifTrue: [
				^ aHostSpace renderer measureTextParagraph: aBlTextParagraph ] ]
		ifAbsent: [ ].

	"TODO"
	host offscreenMeasureTextParagraph: aBlTextParagraph
]

{ #category : #'api - displaying' }
BlSpace >> minimize [
	self hostSpace ifNotNil: [ :hw | hw minimize ]
]

{ #category : #'api - displaying' }
BlSpace >> minimized [
	self hostSpace ifNotNil: [ :hw | ^ hw minimized ].
	^ false
]

{ #category : #'accessing - processors' }
BlSpace >> mouseProcessor [
	
	^ mouseProcessor 
]

{ #category : #'accessing - processors' }
BlSpace >> mouseProcessor: aMouseProcessor [
	mouseProcessor := aMouseProcessor
]

{ #category : #pulse }
BlSpace >> onSessionChanged: aNewSession [

	session := aNewSession.
	self invalidateAll.
	self requestNextPulse.
	
	self root onSessionChanged: aNewSession
]

{ #category : #'window - properties' }
BlSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace position ]
		ifAbsent: [ position ifNil: [ 0@0 ] ]
]

{ #category : #'window - properties' }
BlSpace >> position: aPoint [
	"Request to change window's position to a given point in screen coordinates"

	self setPosition: aPoint.
	self hostSpaceDo: [ :aHostSpace | aHostSpace position: aPoint ]
]

{ #category : #printing }
BlSpace >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		print: title;
		<< ')'
]

{ #category : #pulse }
BlSpace >> processPulse [

	self ensureSession.

	pulseRequested ifFalse: [ ^ self ].

	"flip to false beforehand to be able to know if the next pulse was needed during the frame"
	pulseRequested := false.

	self frame runOn: self
]

{ #category : #pulse }
BlSpace >> pulse [
	self processPulse
]

{ #category : #pulse }
BlSpace >> pulseRequested [
	"Return true if space pulse was requested, false otherwise"

	self
		deprecated: 'Use #isPulseRequested instead'
		transformWith:
			'`@receiver pulseRequested'
			-> '`@receiver isPulseRequested'.

	^ self isPulseRequested
]

{ #category : #'startup - shutdown' }
BlSpace >> rememberVisibleStatus [
	
	previousVisibleStatus := self isVisible
]

{ #category : #pulse }
BlSpace >> render [
	"Render this space in my host window if it is assigned, otherwise do nothing"

	self
		hostSpaceDo: [ :aHostSpace | aHostSpace render: self ]
		"if there is no host we should clear dirty areas, otherwise
		it may lead to memory leaks"
		ifAbsent: [ self clearDirtyElements ]
]

{ #category : #'focus managing' }
BlSpace >> requestFocusFor: anElement dueToRemoval: aFocusReason [
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph owned by this space' ].
		
	self focusProcessor requestFor: anElement dueToRemoval: aFocusReason
]

{ #category : #'change - rendering' }
BlSpace >> requestHostSpaceRedraw [

	self hostSpaceDo: [ :aHostSpace | aHostSpace requestRedraw ]
]

{ #category : #'change - layout' }
BlSpace >> requestLayout: anElement [

	elementsNeedingLayout add: anElement.
	self requestNextPulse
]

{ #category : #pulse }
BlSpace >> requestNextPulse [

	pulseRequested := true
]

{ #category : #'window - properties' }
BlSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	resizable := aBoolean.
	self hostSpaceDo: [ :aHostSpace | aHostSpace resizable: aBoolean ]
]

{ #category : #accessing }
BlSpace >> root [
	"Return my current root element.
	root can not be nil"
	
	^ rootElement
]

{ #category : #accessing }
BlSpace >> root: anElement [
	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"
	

	self
		assert: [ anElement isNotNil ]
		description: [ 'anElement must not be nil' ].

	self
		assert: [ anElement space isNil ]
		description: [ 'New root must not be already have a space assigned!' ].

	rootElement == anElement ifTrue: [ ^ self ].

	anElement
		space: self;
		size: self extent.

	rootElement := anElement.
	self dispatchEvent: BlSpaceRootChangeEvent new

]

{ #category : #accessing }
BlSpace >> rootDo: aBlock [
	"A helper method to evaluate a given block with the root element as its argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #pulse }
BlSpace >> runTasks [
	"Run animations and other runnable tasks"

	self taskQueue runOn: self
]

{ #category : #accessing }
BlSpace >> session [
	^ session
]

{ #category : #'private - accessing' }
BlSpace >> setExtent: anExtent [
	"Actually change space and root extent to a given one"

	extent := anExtent.
	self root requestLayout
]

{ #category : #'private - accessing' }
BlSpace >> setPosition: aPoint [
	"Actually change space, root and glass extent to a given one"

	position := aPoint
]

{ #category : #'host space - accessing' }
BlSpace >> setUpHostSpace [

	hostSpace := host newHostSpaceFor: self
]

{ #category : #'api - displaying' }
BlSpace >> show [
	"Show this space to the user, using current host and other parameters such as extent, title, etc."

	self universe openSpace: self
]

{ #category : #'api - displaying' }
BlSpace >> showSpace: aSpace [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/698'.

	"I show a given space either inside of me or let it open by default"
	aSpace show
]

{ #category : #accessing }
BlSpace >> space [

	^ self
]

{ #category : #'host space - text input' }
BlSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self hostSpaceDo: [:hs | hs startTextInput]
]

{ #category : #'host space - text input' }
BlSpace >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self hostSpaceDo: [:hs | hs startTextInputAtRectangle: aRectangle]
]

{ #category : #'host space - text input' }
BlSpace >> stopTextInput [
	"Stop receiving any text input events"

	self hostSpaceDo: [:hs | hs stopTextInput]
]

{ #category : #'api - tasks' }
BlSpace >> taskQueue [
	<return: #BlSpaceTaskQueue>
	
	^ tasks
]

{ #category : #'host space - accessing' }
BlSpace >> tearDownHostSpace [
	"Detach my current host space if I have one"

	hostSpace ifNil: [ ^ self ].

	hostSpace tearDown.
	hostSpace := nil
]

{ #category : #accessing }
BlSpace >> time [
	<return: #BlTime>
	
	^ time
]

{ #category : #accessing }
BlSpace >> time: aBlTime [
	time := aBlTime
]

{ #category : #'window - properties' }
BlSpace >> title [
	"Return window's title as a string"

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace title ]
		ifAbsent: [ title ]
]

{ #category : #'window - properties' }
BlSpace >> title: aString [
	"Change window's title"

	title := aString.
	self hostSpaceDo: [ :aHostSpace | aHostSpace title: aString ]
]

{ #category : #'api - displaying' }
BlSpace >> toBack [
	self hostSpace ifNotNil: [ :hw | hw toBack ]
]

{ #category : #'api - displaying' }
BlSpace >> toFront [
	self hostSpace ifNotNil: [ :hw | hw toFront ]
]

{ #category : #'focus managing' }
BlSpace >> ungrabFocus [

	self focused: false
]

{ #category : #accessing }
BlSpace >> universe [

	^ self host universe
]

{ #category : #'cursor managing' }
BlSpace >> updateCursor: aCursor [

	self hostSpaceDo: [ :aHostSpace | aHostSpace cursor: aCursor ]
]

{ #category : #accessing }
BlSpace >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them."

	^ userData ifNil: [ userData := IdentityDictionary new ]
]

{ #category : #'window - properties' }
BlSpace >> width [
	<return: #Number>

	^ self extent x
]

{ #category : #'window - properties' }
BlSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"

	<return: #Point>
	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace logicalSize width @ aHostSpace logicalSize height ]
		ifAbsent: [ extent ]
]

{ #category : #'window - properties' }
BlSpace >> windowExtent: anExtent [
	"Request to change a window size to aNewExtent.
	Note, that window size may be different from renderer size on high dpi (retina) displays"

	self setExtent: anExtent.
	self hostSpaceDo: [ :aHostSpace | aHostSpace windowExtent: anExtent ]
]

{ #category : #'window - properties' }
BlSpace >> windowScale [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace scaleFactor ]
		ifAbsent: [ 1.0 asPoint ]
]
