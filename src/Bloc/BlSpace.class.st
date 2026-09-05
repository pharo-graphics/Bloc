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
		'eventQueue',
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
		'userData'
	],
	#category : #'Bloc-Space'
}

{ #category : #initialization }
BlSpace class >> defaultRootLabel [

	^ #'space-root'
]

{ #category : #'private - change' }
BlSpace class >> extractRoots: aSetOfElements [
	self
		deprecated: 'Use BlElementBoundsUpdater >> #extractRoots: instead'
		transformWith: '`@receiver extractRoots: `@arg' -> 'BlElementBoundsUpdater new extractRoots: `@arg'.

	^ BlElementBoundsUpdater new extractRoots: aSetOfElements
]

{ #category : #accessing }
BlSpace >> asReference [
	<return: #BlSpaceReference>

	^ reference ifNil: [ reference := BlAttachedCachedSpaceReference forSpace: self ]
]

{ #category : #'private - pulse' }
BlSpace >> basicPulse [
	"Internal engine driver. Never send me directly.
	I am driven exclusively by BlParallelUniverse during pulse loop cycles.
	To wait for a space to reach equilibrium, send #settle or #deferAndSettle:."

	pulseRequested ifFalse: [ ^ self ].

	"flip to false beforehand to be able to know if the next pulse was needed during the frame"
	pulseRequested := false.

	frame runOn: self
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

	self hostSpaceDo: [ :hw | hw center ]
]

{ #category : #'change - rendering' }
BlSpace >> clearDirtyElements [
	"Clear dirty elements collection, which means there are no pending graphic operations."

	elementsNeedingPaint removeAll
]

{ #category : #'api - displaying' }
BlSpace >> close [
	"Request closing this space. This might happen in a host process (async). 
	This space can be reopened via `open`, either with current host or with another host."
	
	self host closeSpace: self
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
		  id: self defaultRootLabel;
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

	^ self class defaultRootLabel
]

{ #category : #initialization }
BlSpace >> defaultTitle [
	^ ''
]

{ #category : #pulse }
BlSpace >> defer: aBlock [
	"Schedule aBlock to be run asynchronously during a space pulse on the host UI loop process."

	self enqueueTask: (BlTaskAction with: aBlock)
]

{ #category : #pulse }
BlSpace >> deferAndSettle: aBlock [
	"Evaluate aBlock on the UI process and wait until the space reaches equilibrium (all cascading tasks, skins, layout, and render passes have settled)."

	self defer: aBlock.
	self settle
]

{ #category : #pulse }
BlSpace >> deferOrValue: aBlock [
	"Evaluate aBlock immediately if the active process is already the pulse process.
	Otherwise, defer execution by scheduling a task for the next pulse."

	self ifPulseProcessActive: aBlock else: [
		self defer: aBlock ]
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
	self requestPulse
]

{ #category : #'api - events' }
BlSpace >> dequeuedEvents [
	| theEvents |
	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	^ theEvents
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

{ #category : #'api - events' }
BlSpace >> enqueueEvent: aBlEvent [

	eventQueue nextPut: aBlEvent.
	self requestPulse
]

{ #category : #'api - tasks' }
BlSpace >> enqueueTask: aBlTask [
	aBlTask onEnqueued: self.
	self taskQueue enqueue: aBlTask.
	self requestPulse
]

{ #category : #'api - tasks' }
BlSpace >> enqueueTasksFrom: aTaskQueue [

	aTaskQueue isEmpty ifTrue: [ ^ self ].
	aTaskQueue tasks do: [ :eachTask | eachTask onEnqueued: self ].	
	self taskQueue enqueueFrom: aTaskQueue.
	self requestPulse
]

{ #category : #'private - pulse' }
BlSpace >> ensureSession [

	self
		deprecated: 'Session management is handled by BlParallelUniverse on image startup'
		transformWith: '`@receiver ensureSession' -> ''
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
	self
		deprecated: 'Use BlElementBoundsUpdater >> #extractRoots: instead'
		transformWith: '`@receiver extractRoots: `@arg' -> 'BlElementBoundsUpdater new extractRoots: `@arg'.

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

{ #category : #'api - events' }
BlSpace >> hasEvents [
	^ eventQueue isEmpty not
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
	self hostSpaceDo: [ :hw | hw hide ]
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
			| currentHost |
			currentHost := host.
			self
				addEventHandlerOn: BlSpaceDetachedEvent
				doOnce: [
					host := aHost.
					aHost openSpace: self ].

			currentHost closeSpace: self ]
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
	"When host space changed we might want to adapt window extent."

	self windowExtent: self windowExtent.
	"host space changed => renderer changed, we want to redraw the whole space"
	self invalidateAll
]

{ #category : #'host space - accessing' }
BlSpace >> hostSpaceClose [

	hostSpace ifNil: [ ^ self ].

	hostSpace tearDown.
	hostSpace := nil.
	eventQueue removeAll
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

{ #category : #'host space - accessing' }
BlSpace >> hostSpaceOpen [

	hostSpace := host newHostSpaceFor: self.
	hostSpace open
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

{ #category : #pulse }
BlSpace >> ifPulseProcessActive: aBlock else: altBlock [
	"Evaluate aBlock if the active process is the pulse process of this space,
	otherwise evaluate altBlock."

	^ self isPulseProcessActive
		ifTrue: aBlock
		ifFalse: altBlock
]

{ #category : #initialization }
BlSpace >> initialize [

	super initialize.

	host := Bloc preferredHost.
	pulseRequested := true.
	eventQueue := WaitfreeQueue new.
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
	self requestPulse
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
		  hostSpaceDo: [ :aHostSpace | aHostSpace isBorderless ]
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
		hostSpaceDo: [ :aHostSpace | aHostSpace isFullsize ]
		ifAbsent: [ fullsize ]
]

{ #category : #'change - layout' }
BlSpace >> isLayoutRequested [
	"Indicates whether or not root element's layout needs to be updated next frame"
	
	^ self root isLayoutRequested or: [ self elementsNeedingLayout isNotEmpty ]
]

{ #category : #testing }
BlSpace >> isOpened [
	"Return true if the space was shown (by sending #show or #open message), false otherwise.
	Please note, that an opened space can be hidden which does not influence the result of #isOpened"

	^ self host hasSpace: self
]

{ #category : #pulse }
BlSpace >> isPulseProcessActive [
	"Return true if the active process is the pulse loop process for this space"

	^ self host isPulseProcessActive
]

{ #category : #pulse }
BlSpace >> isPulseRequested [
	"Return true if space pulse was requested, false otherwise"

	^ pulseRequested
]

{ #category : #testing }
BlSpace >> isPulsing [

	^ self host isPulsing
]

{ #category : #'window - properties' }
BlSpace >> isResizable [
	"Return true if underlying window is resizable, false otherwise"

	^ self
		hostSpaceDo: [ :aHostSpace | aHostSpace isResizable ]
		ifAbsent: [ resizable ]
]

{ #category : #pulse }
BlSpace >> isSettled [
	"Return true if all frame phases (tasks, layout, skins, events) have reached equilibrium in this space, and there are no pending universe lifecycle actions."

	self host isSettled ifFalse: [ ^ false ].
	self isOpened ifFalse: [ ^ true ].
	^ frame phases allSatisfy: [ :eachPhase | eachPhase isSettledIn: self ]
]

{ #category : #'host space - text input' }
BlSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"

	^ self hostSpaceDo: [:hs | hs isTextInputActive] ifAbsent: [ false ]
]

{ #category : #testing }
BlSpace >> isVisible [
	^ self hostSpaceDo: [ :hs | hs isVisible ] ifAbsent: [ false ]
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
	self requestPulse
]

{ #category : #'api - displaying' }
BlSpace >> maximize [
	self hostSpaceDo: [ :hw | hw maximize ]
]

{ #category : #'api - displaying' }
BlSpace >> maximized [
	^ self hostSpaceDo: [ :hw | hw maximized ] ifAbsent: [ false ]
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
	self hostSpaceDo: [ :hw | hw minimize ]
]

{ #category : #'api - displaying' }
BlSpace >> minimized [
	^ self hostSpaceDo: [ :hw | hw minimized ] ifAbsent: [ false ]
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
BlSpace >> onSessionChanged [

	self invalidateAll.
	self requestHostSpaceRedraw.
	self requestPulse.

	self root onSessionChanged: Smalltalk session
]

{ #category : #pulse }
BlSpace >> onSessionChanged: aNewSession [

	self
		deprecated: 'Use #onSessionChanged instead'
		transformWith: '`@receiver onSessionChanged: `@arg' -> '`@receiver onSessionChanged'.

	self onSessionChanged
]

{ #category : #'api - displaying' }
BlSpace >> open [
	"Open this space on my host."

	self host openSpace: self
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

	self
		deprecated: 'Use #settle instead'
		transformWith: '`@receiver processPulse' -> '`@receiver settle'.

	^ self settle
]

{ #category : #pulse }
BlSpace >> pulse [

	self
		deprecated: 'Direct #pulse on BlSpace causes concurrency races. Use #settle or #deferAndSettle: instead'
		transformWith: '`@receiver pulse' -> '`@receiver settle'.

	^ self settle
]

{ #category : #accessing }
BlSpace >> pulseProcess [
	"Return the pulse loop Process if running, or nil."

	^ self hasHost ifTrue: [ self host pulseProcess ] ifFalse: [ nil ]
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
	self requestPulse
]

{ #category : #pulse }
BlSpace >> requestNextPulse [

	self
		deprecated: 'Use #requestPulse instead'
		transformWith: '`@receiver requestNextPulse' -> '`@receiver requestPulse'.

	self requestPulse
]

{ #category : #pulse }
BlSpace >> requestPulse [

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
		id: self defaultRootLabel;
		extent: self extent.

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

	self
		deprecated: 'Use `Smalltalk session` directly instead.'
		transformWith: '`@receiver session' -> 'Smalltalk session'.

	^ Smalltalk session
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

{ #category : #pulse }
BlSpace >> settle [
	"Wait until the space reaches equilibrium (all deferred actions, tasks, skins, and layout requests have settled).
	Blocks the active process on the host pulse semaphore until #isSettled answers true."

	^ self waitUntilTrue: [ self isSettled ]
]

{ #category : #pulse }
BlSpace >> settleFor: aTimeoutValuable [
	"Wait until the space is settled, or until aTimeoutValuable evaluates to true."

	| finished |
	finished := false.
	self host
		waitUntil: [ self isSettled ]
		timeOutIf: aTimeoutValuable
		onCompletion: [ finished := true ]
		onTimeout: [ finished := false ].
	^ finished
]

{ #category : #pulse }
BlSpace >> settleForDuration: aDuration [
	"Wait for this space task queue to be empty until a given duration has passed.
	Forwards to #settleForMilliseconds: converting the duration to milliseconds."

	^ self settleForMilliseconds: aDuration asMilliSeconds
]

{ #category : #pulse }
BlSpace >> settleForMilliseconds: aNumber [
	"Wait until the space is settled, or until the timeout in milliseconds has passed.
	Uses #nowInUTCMicroseconds for a monotonic, high-resolution deadline to avoid clock-skew issues."

	| deadlineInMicroseconds |
	deadlineInMicroseconds := time nowInUTCMicroseconds + (aNumber * 1000).
	^ self settleFor: [ time nowInUTCMicroseconds >= deadlineInMicroseconds ]
]

{ #category : #'api - displaying' }
BlSpace >> show [
	"Show this space to the user, using current host and other parameters such as extent, title, etc."

	self open
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
	self hostSpaceDo: [ :hw | hw toBack ]
]

{ #category : #'api - displaying' }
BlSpace >> toFront [
	self hostSpaceDo: [ :hw | hw toFront ]
]

{ #category : #'focus managing' }
BlSpace >> ungrabFocus [

	self focused: false
]

{ #category : #accessing }
BlSpace >> universe [

	self
		deprecated: 'Use self host universe instead'
		transformWith: '`@receiver universe' -> '`@receiver host universe'.

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

{ #category : #pulse }
BlSpace >> validateHostSpaceDrawing [

	self hostSpaceDo: [ :aHostSpace |
		aHostSpace hasResized ifTrue: [
			self invalidateAll.
			aHostSpace initializeRenderer ] ]
]

{ #category : #pulse }
BlSpace >> waitForDuration: aDuration [
	"Synchronously wait for the given duration, blocked on the host's pulse loop semaphore.
	
	Note: This is different from `aDuration wait` because it blocks the active process on a pulse semaphore, waking up only on space frame pulses."

	self waitUntilTrue: [ false ] forDuration: aDuration
]

{ #category : #pulse }
BlSpace >> waitUntilTrue: aConditionValuable [
	"Wait until the given condition block evaluates to true, synchronized with the space pulses.
	Blocks the calling process on the host's pulse semaphore, waking up on each frame to check the condition."

	self host
		waitUntil: aConditionValuable
		timeOutIf: [ false ]
		onCompletion: [ ]
		onTimeout: [ ]
]

{ #category : #pulse }
BlSpace >> waitUntilTrue: aConditionValuable forDuration: aDuration [
	"Wait until the given condition block evaluates to true, or the timeout duration has passed.
	Blocks the calling process on the host's pulse semaphore, waking up on each frame to check the condition."

	| deadlineInMicroseconds |
	deadlineInMicroseconds := time nowInUTCMicroseconds + (aDuration asMilliSeconds * 1000).
	self host
		waitUntil: aConditionValuable
		timeOutIf: [ time nowInUTCMicroseconds >= deadlineInMicroseconds ]
		onCompletion: [ ]
		onTimeout: [ ]
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
