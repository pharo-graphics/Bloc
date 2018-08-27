"
I am the logical representation of a window in Bloc regardless the current Host in use.

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
		'root',
		'resizable',
		'borderless',
		'rootStyler',
		'dirtyAreas',
		'eventDispatcher',
		'eventListener',
		'eventRecorder',
		'mouseProcessor',
		'focusProcessor',
		'keyboardProcessor',
		'focusOwner',
		'dragboard',
		'nextPulseRequested',
		'currentCursor',
		'session',
		'focused',
		'title',
		'fullscreen',
		'layoutError',
		'tasks',
		'time',
		'touchProcessor'
	],
	#category : 'Bloc-Space'
}

{ #category : #'debug - simulation' }
BlSpace class >> locationOutside: anElement [
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height atRandom).
		theBounds bottomLeft + (theBounds width atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateClickOn: anElement [
	"Simulate a click event in the middle of a given element by
	performing mouse down and mouse up events in a sequence"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace center.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
		on: anElement
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
			BlMouseDownEvent primary position: aPosition.
			BlMouseUpEvent primary position: aPosition }
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
	
	aDelta := (anElement localBoundsToGlobal: (BlBounds origin: 0@0 extent: aBlVector)) extent.
	
	"we simulate a click with a sequence of low level mouse down/up events"
	self
		simulateEvents: {
			BlMouseDownEvent primary position: aPosition.
			BlMouseMoveEvent primary position: aPosition + aDelta.
			BlMouseUpEvent primary position: aPosition + aDelta }
		on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	"I simulate a given low level space UI event such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordiantes of the provided element.
	Note: I create a temporary space if provided element does not have one. if you need to simulate
	of sequence of dependent events it is better to use #simulateEvents:on: directy"

	self simulateEvents: { anEvent } on: anElement
]

{ #category : #'debug - simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	"I simulate a given sequence of low level space UI events such as MouseUp/MouseDown or keyboard.
	If you would like to simulate a higher level event you could directly fire or dispatch them
	by asking any element to #fireEvent: or #dispatchEvent:
	Note: UI mouse events require to set #position: given in space coordinates or in root most parent
	coordiantes of the provided element"
	
	"we should update timestamps"
	aCollectionOfEvents do: [ :anEvent | anEvent timestamp: DateAndTime now ].
	
	anElement isAttachedToSceneGraph
		ifTrue: [
			anElement space pulse.
			aCollectionOfEvents do: [ :anEvent | anElement space dispatchEvent: anEvent ].
			anElement space pulse ]
		ifFalse: [ 
			| temporarySpace topMostElement |
			topMostElement := anElement topMostParent.
			[ 
				temporarySpace := self new.
				temporarySpace root addChild: topMostElement.
				temporarySpace pulse.
				aCollectionOfEvents do: [ :anEvent | temporarySpace dispatchEvent: anEvent ].
				temporarySpace pulse
			] ensure: [ topMostElement removeFromParent ] ]
	
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
BlSpace class >> simulateMouseMoveInside: anElement [
	"Simulate a mouse move event at a random location within element's bounds"
	| aPosition |
	
	"we never know if an element was already layered out"
	anElement topMostParent forceLayout.
	aPosition := anElement bounds inSpace bounds atRandom.

	self
		simulateEvents: { BlMouseMoveEvent primary position: aPosition }
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
		simulateEvents: { BlMouseUpEvent primary position: aPosition }
		on: anElement
]

{ #category : #'api - adding' }
BlSpace >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	
	self root addChild: anElement
]

{ #category : #'change reporting' }
BlSpace >> beDirtyArea [
	self makeDirty: (BlBounds origin: 0 @ 0 extent: self extent)
]

{ #category : #'window - properties' }
BlSpace >> borderless [
	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace borderless ]
		ifNil: [ borderless ]
]

{ #category : #'window - properties' }
BlSpace >> borderless: aBoolean [
	borderless := aBoolean.
	 self hostSpace ifNotNil: [ :hw | hw borderless: aBoolean ].
]

{ #category : #'event management' }
BlSpace >> buildEventDispatchChain: aBlEventDispatcherChain [
	<return: #BlEventDispatcherChain>

	^ aBlEventDispatcherChain
]

{ #category : #'change reporting' }
BlSpace >> clearDirtyAreas [
	"Clear all dirty areas.
	Default implementation simply removes all areas from the collection"

	self dirtyAreas removeAll
]

{ #category : #displaying }
BlSpace >> close [
	"Delegate closing work to the Universe"
	BlUniverse default closeSpaceWindow: self
]

{ #category : #'cursor managing' }
BlSpace >> currentCursor [
	^ currentCursor 
]

{ #category : #'cursor managing' }
BlSpace >> currentCursor: aCursor [

	currentCursor ifNotNil: [ :cc | cc deactivateOn: self ].
	currentCursor := aCursor.
	currentCursor ifNil: [ ^ self updateCursorImage: Cursor normal ].
	currentCursor activateOn: self
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
BlSpace >> defaultEventRecorder [
	^ BlEmptyEventRecorder new
]

{ #category : #'change reporting' }
BlSpace >> defaultExtent [
	^ 800@600
]

{ #category : #initialization }
BlSpace >> defaultRoot [
	^ BlElement new
		background: self defaultRootBackground;
		labeled: self defaultRootLabel;
		yourself
]

{ #category : #initialization }
BlSpace >> defaultRootBackground [
	^ Color white
]

{ #category : #initialization }
BlSpace >> defaultRootLabel [
	^ 'Root element'
]

{ #category : #initialization }
BlSpace >> defaultRootStyler [
	^ self class environment
		at: #BrRootStyler
		ifPresent: [ :aStylerClass | aStylerClass on: self root ]
		ifAbsent: [ BlNullStyler new ]
]

{ #category : #initialization }
BlSpace >> defaultTitle [
	^ ''
]

{ #category : #'dragboard managing' }
BlSpace >> deleteDragboard [
	| d |
	d := self dragboard.
	self dragboard clear.
	self dragboard: nil.
	^ d
]

{ #category : #accessing }
BlSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>

	self hostSpace
		ifNotNil: [ :hw | ^ hw densityDpi ].

	"Without actual window we can only guess"
	^ 96.0
]

{ #category : #'api - tasks' }
BlSpace >> dequeueTask: aBlTask [
	self taskQueue dequeue: aBlTask
]

{ #category : #'host - accessing' }
BlSpace >> detachHostSpace [
	"Detach my current host space if I have one"

	self hostSpaceProperty value: nil
]

{ #category : #accessing }
BlSpace >> dirtyAreas [
	<return: #SequenceableCollection of: #BlBounds>

	^ dirtyAreas
]

{ #category : #pulse }
BlSpace >> dispatchTimeEvent: aSpaceStepEventClass during: aBlock [
	| aStartTime |
	
	aStartTime := self time now.
	aBlock value.
	self eventDispatcher dispatchEvent:
			(aSpaceStepEventClass new
				start: aStartTime;
				end: self time now;
				yourself)
]

{ #category : #pulse }
BlSpace >> doLayout [
	| layoutCounter maxLayoutCount |

	self
		assert: [ self isLayoutRequested ]
		description: [ 'Root element must request layout in order to update it' ].

	[
		layoutCounter := 0.
		maxLayoutCount := 100.

		[ self hasLayoutError not and: [ self root isLayoutRequested and: [ layoutCounter < maxLayoutCount ] ] ]
			whileTrue: [
				self doUpdateLayout.
				layoutCounter := layoutCounter + 1.
				layoutCounter = 50
					ifTrue: [ 'Warning: Layout was performed 50 times per frame!' logCr ] ].

		self root dispatchLayoutDone

	"I prevent infinite spawn of debuggers"
	] on: Error do: [ :anError |
		layoutError := anError.
		[ layoutError debug ] ensure: [ layoutError := nil ] ]
]

{ #category : #pulse }
BlSpace >> doUpdateFocus [
	self focusOwner
		ifNil: [ self initializeFocus ]
		ifNotNil: [ :anElement |
			anElement space == self
				ifFalse: [
					self focusOwner: nil.
					self initializeFocus ] ]
]

{ #category : #pulse }
BlSpace >> doUpdateLayout [
	"Start layouting process"

	self doUpdateLayout: self root
]

{ #category : #pulse }
BlSpace >> doUpdateLayout: anElement [
	"Perform layout of a given element (e.g. root or glass)"

	"first we measure.."
	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec new beExact: self width)
			usedSize:  0
			resizer: BlLayoutResizer matchParent);
		heightSpec: (anElement layout
			measurementSpecFor: (BlMeasurementSpec new beExact: self height)
			usedSize:  0
			resizer: BlLayoutResizer matchParent)).

	"...then we layout in measured during previous step bounds"
	anElement applyLayoutIn: anElement measuredBounds asRectangle.
	anElement commitChanges
]

{ #category : #accessing }
BlSpace >> dragboard [
	^ dragboard
]

{ #category : #accessing }
BlSpace >> dragboard: anObject [
	dragboard := anObject
]

{ #category : #'api - tasks' }
BlSpace >> enqueueTask: aBlTask [
	aBlTask onEnqueued: self.
	self taskQueue enqueue: aBlTask.
]

{ #category : #pulse }
BlSpace >> ensureSession [
	"Check current session and perform required operations if it changed since last frame"

	session == Smalltalk session
		ifTrue: [ ^ self ].

	session := Smalltalk session.
	self beDirtyArea.
	self requestNextPulse
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
BlSpace >> eventListener: anObject [
	eventListener := anObject
]

{ #category : #accessing }
BlSpace >> eventRecorder [
	^ eventRecorder
]

{ #category : #accessing }
BlSpace >> eventRecorder: anEventRecorder [
	eventRecorder := anEventRecorder
]

{ #category : #accessing }
BlSpace >> extent [
	<return: #Point>

	^ self windowExtent
]

{ #category : #accessing }
BlSpace >> extent: aNewExtent [
	self windowExtent: aNewExtent
]

{ #category : #'focus managing' }
BlSpace >> focusOwner [
	^ focusOwner
]

{ #category : #'focus managing' }
BlSpace >> focusOwner: anElement [
	focusOwner := anElement
]

{ #category : #accessing }
BlSpace >> focusProcessor [
	<return: #BlFocusProcessor>

	^ focusProcessor
]

{ #category : #accessing }
BlSpace >> focusProcessor: aFocusProcessor [
	focusProcessor := aFocusProcessor
]

{ #category : #accessing }
BlSpace >> focused [
	<return: #Boolean>

	^ self focusedProperty value
]

{ #category : #accessing }
BlSpace >> focused: aBoolean [
	self focusedProperty value: aBoolean
]

{ #category : #'accessing properties' }
BlSpace >> focusedProperty [
	^ focused ifNil: [ focused := BlObjectProperty on: self named: #focused default: false ]
]

{ #category : #drawing }
BlSpace >> fullDrawOn: anCanvas [
	anCanvas fullDraw: self root
]

{ #category : #'window - properties' }
BlSpace >> fullscreen [
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace fullscreen ]
		ifNil: [ fullscreen ]
]

{ #category : #'window - properties' }
BlSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	fullscreen := aBoolean.
	 self hostSpace ifNotNil: [ :aHostSpace | aHostSpace fullscreen: aBoolean ]
]

{ #category : #'focus managing' }
BlSpace >> grabFocus [
	self focused: true
]

{ #category : #testing }
BlSpace >> hasDirtyAreas [
	"Return true if space has dirty areas and therefore needs to be rendered,
	false otherwise"
	<return: #Boolean>
	
	^ self dirtyAreas isNotEmpty
]

{ #category : #testing }
BlSpace >> hasHostSpace [
	"Return true if I have a host space, false otherwise"
	<return: #Boolean>

	^ self hostSpace isNotNil
]

{ #category : #testing }
BlSpace >> hasLayoutError [
	"Return true if there was a layout error, false otherwise"
	<return: #Boolean>

	^ layoutError isNotNil
]

{ #category : #accessing }
BlSpace >> height [
	<return: #Number>

	^ self extent y
]

{ #category : #displaying }
BlSpace >> hide [
	self hostSpace ifNotNil: [ :hw | hw hide ]
]

{ #category : #'host - accessing' }
BlSpace >> host [
	^ host
]

{ #category : #'host - accessing' }
BlSpace >> host: aHost [
	host := aHost
]

{ #category : #'host - accessing' }
BlSpace >> hostSpace [
	^ self hostSpaceProperty value
]

{ #category : #'host - accessing' }
BlSpace >> hostSpace: aHostSpace [
	"Assign a host space window that will be a source of UI events
	and will provide a rendering surface on which I will be rendered.
	aHostSpace must not be nil"

	self
		assert: [ aHostSpace isNotNil ]
		description: [ 'Host space must not be nil!' ].

	self hostSpaceProperty value: aHostSpace.
	self hostSpaceChanged.
]

{ #category : #'as yet unclassified' }
BlSpace >> hostSpaceChanged [
	"When host space changed we might want to adapt sizes"
	self windowExtent: self windowExtent.
	"host space changed => renderer changed, we want to redraw the whole space"
	self beDirtyArea
]

{ #category : #'accessing properties' }
BlSpace >> hostSpaceProperty [
	^ hostSpace ifNil: [ hostSpace := BlObjectProperty on: self named: #hostSpace ]
]

{ #category : #initialization }
BlSpace >> initDispatcher [
	self eventDispatcher addEventFilter: self eventListener
]

{ #category : #initialization }
BlSpace >> initialize [
	super initialize.
	
	nextPulseRequested := true.
	session := Smalltalk session.
	dirtyAreas := OrderedCollection new.
	
	eventDispatcher := self defaultEventDispatcher.
	eventListener := self defaultEventListener.
	eventRecorder := self defaultEventRecorder.
	self initDispatcher.
	
	mouseProcessor := BlMouseProcessor space: self.
	focusProcessor := BlFocusProcessor space: self.
	keyboardProcessor := BlKeyboardProcessor space: self.
	touchProcessor := BlTouchProcessor space: self.

	tasks := BlTaskQueue new.
	time := BlTime real.

	root := self defaultRoot.

	rootStyler := self defaultRootStyler.

	self extent: self defaultExtent.
	self position: 0@0.

	self resizable: true.
	self borderless: false.
	self fullscreen: false.
	self title: self defaultTitle.

	self updateCursorImage: Cursor normal.

	self root space: self
]

{ #category : #'focus managing' }
BlSpace >> initializeFocus [
	self root isFocusable
		ifTrue: [ self root requestFocus ]
]

{ #category : #'change reporting' }
BlSpace >> invalidRect: aBlBounds from: anElement [

	self makeDirty: aBlBounds.
	self requestNextPulse
]

{ #category : #testing }
BlSpace >> isFocused [
	^ self focused
]

{ #category : #testing }
BlSpace >> isLayoutRequested [
	"Indicates whether or not root element's layout needs to be updated next frame"
	<return: #Boolean>
	
	^ self root isLayoutRequested
]

{ #category : #testing }
BlSpace >> isVisible [
	^ self hasHostSpace
		ifTrue: [ self hostSpace isVisible ]
		ifFalse: [ false ]
]

{ #category : #accessing }
BlSpace >> keyboardProcessor [
	<return: #BlKeyboardProcessor>

	^ keyboardProcessor
]

{ #category : #accessing }
BlSpace >> keyboardProcessor: aKeyboardProcessor [
	keyboardProcessor := aKeyboardProcessor
]

{ #category : #'focus managing' }
BlSpace >> looseFocusFor: anElement [
			
	self focusProcessor looseFor: anElement
]

{ #category : #'change reporting' }
BlSpace >> makeDirty: aBlBounds [

	self
		assert: [ aBlBounds isKindOf: BlBounds ]
		description: [ 'Only BlBounds can be used as dirty area' ].

	aBlBounds expanded.
	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aBlBounds copy ]
		ifNotEmpty: [ :aCollection | aCollection first merge: aBlBounds ].
]

{ #category : #displaying }
BlSpace >> maximize [
	self hostSpace ifNotNil: [ :hw | hw maximize ]
]

{ #category : #displaying }
BlSpace >> maximized [
	self hostSpace ifNotNil: [ :hw | ^ hw maximized ].
	^ false
]

{ #category : #displaying }
BlSpace >> minimize [
	self hostSpace ifNotNil: [ :hw | hw minimize ]
]

{ #category : #displaying }
BlSpace >> minimized [
	self hostSpace ifNotNil: [ :hw | ^ hw minimized ].
	^ false
]

{ #category : #accessing }
BlSpace >> mouseProcessor [
	<return: #BlMouseProcessor>

	^ mouseProcessor
]

{ #category : #accessing }
BlSpace >> mouseProcessor: aMouseProcessor [
	mouseProcessor := aMouseProcessor
]

{ #category : #'dragboard managing' }
BlSpace >> newDragboard [
	self dragboard: (BlDragboard space: self).
	^ self dragboard
]

{ #category : #'window - properties' }
BlSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace position ]
		ifNil: [ position ]
]

{ #category : #accessing }
BlSpace >> position: aPoint [
	"Request to change window's position to a given point in screen corrdinates"

	self hasHostSpace
		ifTrue: [ self hostSpace position: aPoint ]
		ifFalse: [ self setPosition: aPoint ]
]

{ #category : #pulse }
BlSpace >> processEvents [
	"Process events enqueued by host space and dispatch them to the scene graph"

	self
		assert: [ self hasHostSpace ]
		description: [ 'Events can only be processed if I have a host space' ].

	self eventRecorder onPulse.
	self hostSpace fetchedEventsDo: [ :anEvent |
		self eventRecorder record: anEvent.
		self eventDispatcher dispatchEvent: anEvent ].

	self mouseProcessor generateEvents
]

{ #category : #pulse }
BlSpace >> processPulse [
	self ensureSession.

	"We must update focused element before processing events, otherwise keyboard events,
	for example, will be handled by the wrong element"
	self doUpdateFocus.

	self
		dispatchTimeEvent: BlSpaceEventProcessEndEvent
		during: [ self hasHostSpace ifTrue: [ self processEvents ] ].

	"process animations and other runnable tasks"
	self
		dispatchTimeEvent: BlSpaceTasksEndEvent
		during: [ self runTasks ].

	self pulseRequested
		ifFalse: [ ^ self ].

	self
		dispatchTimeEvent: BlSpaceLayoutEndEvent
		during: [ self isLayoutRequested ifTrue: [ self doLayout ] ].

	self
		dispatchTimeEvent: BlSpaceRenderEndEvent
		during: [ self hasDirtyAreas ifTrue: [ self render ] ].
		
	nextPulseRequested := false
]

{ #category : #pulse }
BlSpace >> pulse [
	[ self processPulse ]
		on: Error
		do: [ :anError |
			anError freeze.
			[ anError debug ] fork.
			self dispatchEvent: (BlSpaceErrorEvent on: anError) ]
]

{ #category : #'change reporting' }
BlSpace >> pulseRequested [
	"Return true if space pulse was requested, false otherwise"
	<return: #Boolean>

	^ nextPulseRequested
]

{ #category : #pulse }
BlSpace >> render [
	"Render this space in my host window if it is assigned, otherwise do nothing"

	self
		assert: [ self hasDirtyAreas ]
		description: [ 'I must have dirty areas in order to be rendered' ].

	self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace render: self ]
]

{ #category : #'focus managing' }
BlSpace >> requestFocusFor: anElement [
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph owned by this space' ].
		
	self focusProcessor requestFor: anElement
]

{ #category : #'change reporting' }
BlSpace >> requestNextPulse [
	nextPulseRequested := true.
	
	"By the contract next pulse can be only requested if universe is running.
	It is done to not create pulse loop when it is actually not needed (for example during testing)"
	BlUniverse default isRunning
		ifTrue: [ BlUniverse default requestNextPulse ]
]

{ #category : #'window - properties' }
BlSpace >> resizable [
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace resizable ]
		ifNil: [ resizable ]
]

{ #category : #'window - properties' }
BlSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	resizable := aBoolean.
	self hostSpace ifNotNil: [ :aHostSpace | aHostSpace resizable: aBoolean ]
]

{ #category : #accessing }
BlSpace >> root [
	"Return my current root element.
	root can not be nil"
	<return: #BlElement>
	
	self
		assert: [ root isNotNil ]
		description: [ 'Root must not be nil' ].
	
	^ root
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

	anElement
		space: self;
		size: self extent.

	root := anElement.
	"Root styler is created for the root element. Since we change root element
	we must also recreate a styler"
	rootStyler := self defaultRootStyler
]

{ #category : #accessing }
BlSpace >> rootDo: aBlock [
	"A helper method to evaluate a given block with root element an argument.
	May be useful for scripting"

	aBlock value: self root
]

{ #category : #accessing }
BlSpace >> rootStyler [
	^ rootStyler
]

{ #category : #pulse }
BlSpace >> runTasks [
	"Run animations and other runnable tasks"

	self taskQueue run
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

{ #category : #displaying }
BlSpace >> show [
	"Open me in a window and show it to the user"

	"delegate showing work to the Universe"
	BlUniverse default showSpaceWindow: self.
	
	"Notify root element that it is now visible to the user"
	root dispatchAddedToSceneGraph.
	
	self requestNextPulse.
]

{ #category : #'api - tasks' }
BlSpace >> taskQueue [
	<return: #BlTaskQueue>
	
	^ tasks
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
	<return: #String>

	^ self titleProperty value
]

{ #category : #'window - properties' }
BlSpace >> title: aString [
	"Change window's title"

	self titleProperty value: aString
]

{ #category : #'accessing properties' }
BlSpace >> titleProperty [
	^ title ifNil: [
		title := BlDelegateProperty
			on: self
			named: #title
			delegateTo: self hostSpaceProperty ]
]

{ #category : #displaying }
BlSpace >> toBack [
	self hostSpace ifNotNil: [ :hw | hw toBack ]
]

{ #category : #displaying }
BlSpace >> toFront [
	self hostSpace ifNotNil: [ :hw | hw toFront ]
]

{ #category : #accessing }
BlSpace >> topMostParent [
	^ self root
]

{ #category : #accessing }
BlSpace >> touchProcessor [
	<return: #BlTouchProcessor>

	^ touchProcessor
]

{ #category : #'focus managing' }
BlSpace >> transferFocusTo: anElement [
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph owned by this space' ].
		
	self focusProcessor transferTo: anElement
]

{ #category : #'focus managing' }
BlSpace >> ungrabFocus [
	self focused: false
]

{ #category : #'cursor managing' }
BlSpace >> updateCursorImage: anImage [

	self hostSpace ifNotNil: [ :aHostSpace |
		aHostSpace cursor: anImage ]
]

{ #category : #accessing }
BlSpace >> width [
	<return: #Number>

	^ self extent x
]

{ #category : #accessing }
BlSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"
	<return: #Point>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace windowExtent ]
		ifNil: [ extent ]
]

{ #category : #accessing }
BlSpace >> windowExtent: anExtent [
	"Request to change a window size to aNewExtent.
	Note, that window size may be different from renderer size on high dpi (retina) displays"

	self hasHostSpace
		ifTrue: [ self hostSpace windowExtent: anExtent ]
		ifFalse: [ self setExtent: anExtent ]
]

{ #category : #accessing }
BlSpace >> windowScale [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace scaleFactor ]
		ifNil: [ 1.0 asPoint ]
]
