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

{ #category : #'accessing - method dictionary' }
BlSpace class >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol [
	"When a new methods is added, I add it to the localMethodDict and also propagate the changes to my users"
	<reflection: 'Class structural modification - Selector/Method modification'>
	self localMethodDict at: selector put: compiledMethod.

	super addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol.

	TraitChange addSelector: selector on: self
]

{ #category : #querying }
BlSpace class >> allTraits [
	<reflection: 'Class structural inspection - Traits'>
	^ self traitComposition allTraits
]

{ #category : #'debug - asserting' }
BlSpace class >> assert: aBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	We check for true explicitly to make the assertion fail for non booleans.
	
	Note: Should be enabled with ===Bloc enableAssertions==="
	
	self assertionsEnabled
		ifTrue: [ aBlock value == true ifFalse: [ AssertionFailure signal: 'Assertion failed' ] ]
]

{ #category : #'debug - asserting' }
BlSpace class >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	
	Note: Should be enabled with ===Bloc enableAssertions==="

	self assertionsEnabled
		ifTrue: [ aBlock value == true ifFalse: [ AssertionFailure signal: aStringOrBlock value ] ]
]

{ #category : #'debug - asserting' }
BlSpace class >> assertionsEnabled [

	^ Bloc assertionsEnabled
]

{ #category : #initialization }
BlSpace class >> doRebuildMethodDictionary [

	| selectors removedSelectors modified |
	"During the creation of the class or after a change in the traitComposition, the whole method dictionary is calculated.
	If I return true, my users should be updated""1. I recreate the local methodDict"
	modified := false.
	self methodDict valuesDo: [ :m | m traitSource ifNil: [ self localMethodDict at: m selector put: m ] ].

	"2. I filter the selectors from the trait composition, rejecting the ones that are locally defined.
	And then I install the methods in myself. The trait composition only install the method if it is needed."
	selectors := self traitComposition selectors reject: [ :e | self localMethodDict includesKey: e ].
	selectors do: [ :e | modified := modified | (self traitComposition installSelector: e into: self replacing: false) ].

	"3. I handle the methods that I have and they are no more in the traitComposition."
	removedSelectors := self methodDict keys reject: [ :aSelector | (selectors includes: aSelector) or: [ self localMethodDict includesKey: aSelector ] ].
	modified := modified | removedSelectors isNotEmpty.
	removedSelectors do: [ :aSelector |
		self methodDict removeKey: aSelector.
		self removeFromProtocols: aSelector ].

	^ modified
]

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

{ #category : #testing }
BlSpace class >> findOriginClassOf: aMethod [

	"I return the myself or the trait that has the original implementation of a method.
	If the method is an alias, the returned class includes the original aliased method"
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	
	(aMethod hasProperty: #traitSource)
		ifTrue: [ ^ aMethod traitSource innerClass ].

	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ self ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ ^ self ]) innerClass
]

{ #category : #testing }
BlSpace class >> findOriginMethodOf: aMethod [

	"I return the original method for a aMethod.
	If this is a local method, the original method is itself.
	If it cames from a trait composition I look for the method in the trait composition.
	First I try with the trait stored in the traitSource.
	If it is an aliased or conflicting method, the method is look up in the whole trait composition"
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	
	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ aMethod ].

	(aMethod hasProperty: #traitSource)
		ifTrue: [ |newSelector|
			newSelector := self traitComposition originSelectorOf: aMethod selector.
			^ aMethod traitSource compiledMethodAt: newSelector ifAbsent: [aMethod] ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ self ])
		compiledMethodAt: aMethod selector ifAbsent: [ ^ aMethod ]
]

{ #category : #testing }
BlSpace class >> hasTraitComposition [

	^ self traitComposition isEmpty not
]

{ #category : #testing }
BlSpace class >> includesLocalSelector: aSymbol [
	<reflection: 'Class structural inspection - Shared pool inspection'>
	^ self isLocalSelector: aSymbol
]

{ #category : #testing }
BlSpace class >> includesTrait: aTrait [

	<reflection: 'Class structural inspection - Traits'>
	^ self traitComposition includesTrait: aTrait
]

{ #category : #testing }
BlSpace class >> isAliasSelector: aSymbol [
	"Return true if the selector aSymbol is an alias defined
	in my or in another composition somewhere deeper in
	the tree of traits compositions."

	^ self traitComposition isAliasSelector: aSymbol
]

{ #category : #testing }
BlSpace class >> isLocalAliasSelector: aSymbol [
	"Return true if the selector aSymbol is an alias defined
	in my trait composition."

	^ self traitComposition isLocalAliasSelector: aSymbol
]

{ #category : #testing }
BlSpace class >> isLocalSelector: aSelector [
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	^ self localMethodDict includesKey: aSelector
]

{ #category : #accessing }
BlSpace class >> localMethodDict [
	"The local methodDict is in the metaclass. In this way I do not have to recompile the methods during the bootstrap when we don't have a compiler."
	^ self class baseLocalMethods
]

{ #category : #accessing }
BlSpace class >> localMethodDict: aMethodDictionary [
	^ self class baseLocalMethods: aMethodDictionary
]

{ #category : #accessing }
BlSpace class >> localMethods [
	"returns the methods of classes excluding the ones of the traits that the class uses"
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	^ self localMethodDict values
]

{ #category : #'accessing - method dictionary' }
BlSpace class >> localSelectors [
	<reflection: 'Class structural inspection - Selectors and methods inspection'>
	^ self localMethodDict keys
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

{ #category : #initialization }
BlSpace class >> rebuildMethodDictionary [

	"Useful to be rewritten in Traits"
	^ self doRebuildMethodDictionary
]

{ #category : #categories }
BlSpace class >> recategorizeSelector: selector from: oldProtocol to: newProtocol [
	"When a method is recategorized I have to classify the method, but also recategorize the aliases pointing to it"

	| originalProtocol |
	"If it is nil is because it is a removal. It will removed when the method is removed."
	newProtocol ifNil: [ ^ self ].

	originalProtocol := (self protocolOfSelector: selector) ifNil: [ ^ self ].
	originalProtocol name = oldProtocol name ifTrue: [ self classify: selector under: newProtocol name ].

	(self traitComposition reverseAlias: selector) do: [ :selectorAlias |
		self recategorizeSelector: selectorAlias from: oldProtocol to: newProtocol.
		self notifyOfRecategorizedSelector: selectorAlias from: oldProtocol to: newProtocol ]
]

{ #category : #recompilation }
BlSpace class >> recompile: selector from: oldClass [

	super recompile: selector from: oldClass.
	TraitChange addSelector: selector on: self
]

{ #category : #'trait-composition' }
BlSpace class >> removeFromComposition: aTrait [

	self setTraitComposition: (self traitComposition copyWithoutTrait: aTrait asTraitComposition)
]

{ #category : #removing }
BlSpace class >> removeFromSystem: logged [

	"When a traited class is removed the traits it is using should be updated"
	| mySubclasses |
	self traitComposition removeUser: self.
	self class traitComposition removeUser: self class.

	TraitedClass removeUser: self class.

	mySubclasses := self subclasses.

	super removeFromSystem: logged.

	"As I am a traited class my subclasses does not have the basic traited class
	methods, so I add them."
	mySubclasses do: [ :each | each class initializeBasicMethods ]
]

{ #category : #removing }
BlSpace class >> removeSelector: aSelector [

	"When a selector is removed it should be notified to my users.
	Check the class TraitChange for more details"
	<reflection: 'Class structural modification - Selector/Method modification'>
	super removeSelector: aSelector.
	self localMethodDict removeKey: aSelector ifAbsent: [  ].

	TraitChange removeSelector: aSelector on: self
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
BlSpace class >> traitComposition [
	"My trait composition is in my class. So I do not need to recompile the methods when installing them during bootstrap"
	^ self class baseComposition
]

{ #category : #accessing }
BlSpace class >> traitComposition: aComposition [

	aComposition asTraitComposition allTraits do: [ :aMaybeTrait |
		aMaybeTrait isTrait ifFalse: [
			self error: 'All the members of the trait composition should be traits' ]].

	self class baseComposition: aComposition
]

{ #category : #accessing }
BlSpace class >> traitCompositionString [
	^ self traitComposition asString
]

{ #category : #accessing }
BlSpace class >> traitUsers [
	"I am a traited class, I have no users, this is for compatibility with traits"
		<reflection: 'Class structural inspection - Traits'>
	^ #()
]

{ #category : #accessing }
BlSpace class >> traits [
	<reflection: 'Class structural inspection - Traits'>
	^ self traitComposition traits
]

{ #category : #'event management' }
BlSpace >> addEventFilter: anEventHandler [
	self eventDispatcher addEventFilter: anEventHandler
]

{ #category : #'event management' }
BlSpace >> addEventFilterOn: anEventClass do: aBlock [

	| newEventHandler |
	newEventHandler :=
		BlEventHandler
			on: anEventClass
			do: aBlock.

	self addEventFilter: newEventHandler.
	
	^ newEventHandler
]

{ #category : #'event management' }
BlSpace >> addEventHandler: anEventHandler [
	self eventDispatcher addEventHandler: anEventHandler
]

{ #category : #'event management' }
BlSpace >> addEventHandlerIfNotPresent: anEventHandler [
	(self hasEventHandler: anEventHandler)
		ifTrue: [ ^ self ].

	self addEventHandler: anEventHandler
]

{ #category : #'event management' }
BlSpace >> addEventHandlerOn: anEventClass do: aBlock [
	"Add a new event handler for the received event class, and answer the new handler."
	
	| newEventHandler |
	newEventHandler :=
		BlEventHandler
			on: anEventClass
			do: aBlock.

	self addEventHandler: newEventHandler.

	^ newEventHandler
]

{ #category : #'event management' }
BlSpace >> addEventHandlerOn: anEventClass doOnce: aBlock [
	"Add an event handler that will be removed right before culling the received block closure.
	Answer the new `BlEventHandler`."

	| anEventHandler |
	anEventHandler := BlEventHandler new.
	anEventHandler
		eventClass: anEventClass;
		action: [ :anEvent |
			self removeEventHandler: anEventHandler.
			aBlock cull: anEvent ].
	
	self addEventHandler: anEventHandler.
	
	^ anEventHandler
]

{ #category : #'shortcut management' }
BlSpace >> addShortcut: aShortcut [
	self eventDispatcher addShortcut: aShortcut
]

{ #category : #accessing }
BlSpace >> asReference [
	<return: #BlSpaceReference>

	^ reference ifNil: [ reference := BlAttachedCachedSpaceReference forSpace: self ]
]

{ #category : #'debug - asserting' }
BlSpace >> assert: aBlock [
	"Throw an assertion error if aBlock does not evaluates to true"
	
	self class assert: aBlock
]

{ #category : #'debug - asserting' }
BlSpace >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true."

	self class assert: aBlock description: aStringOrBlock
]

{ #category : #'debug - asserting' }
BlSpace >> assert: actual equals: expected [
	^ self
		assert: actual = expected
		description: [self comparingStringBetween: actual and: expected]
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

{ #category : #'event management' }
BlSpace >> buildEventDispatchChain: aBlEventDispatcherChain [
	"Note: Dispatcher chain is persistent - I return a new instance"
	<return: #BlEventDispatcherChain>
	| aResultChain |

	aResultChain := aBlEventDispatcherChain.
	aResultChain := aResultChain withNext: self eventDispatcher.

	self hasNextEventTarget
		ifTrue: [ aResultChain := self nextEventTarget buildEventDispatchChain: aResultChain ].

	^ aResultChain
]

{ #category : #'event management' }
BlSpace >> buildEventDispatchChain: aBlEventDispatcherChain upTo: anOtherEventTarget [
	"Build an event dispatch chain up to but excluding a given other event target
	Note: Dispatcher chain is persistent - I return a new instance"
	<return: #BlEventDispatcherChain>
	| aResultChain |

	aResultChain := aBlEventDispatcherChain.
	aResultChain := aResultChain withNext: self eventDispatcher.

	(self hasNextEventTarget and: [ self nextEventTarget ~~ anOtherEventTarget ])
		ifTrue: [ aResultChain := self nextEventTarget buildEventDispatchChain: aResultChain upTo: anOtherEventTarget ].

	^ aResultChain
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

{ #category : #'debug - asserting' }
BlSpace >> comparingStringBetween: actual and: expected [

	^ String streamContents: [:stream |
			stream
				nextPutAll: 'Got ';
				nextPutAll: actual fullPrintString;
				nextPutAll: ' instead of ';
				nextPutAll: expected fullPrintString;
				nextPutAll: '.']
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
BlSpace >> damagedRectangles [

	^ elementsNeedingPaint collect: [ :each |
		each lastDrawBoundsInSpace
			ifNotNil: [ :old |
				each invalidationBoundsInSpace merge: old ]
			ifNil: [
				each invalidationBoundsInSpace ] ]
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

{ #category : #'host space - accessing' }
BlSpace >> detachHostSpace [
	"Detach my current host space if I have one"

	hostSpace := nil
]

{ #category : #'children dispatching' }
BlSpace >> dispatchAddedToSceneGraph [
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self root dispatchAddedToSceneGraph

]

{ #category : #'event management' }
BlSpace >> dispatchEvent: anEvent [
	"Dispatch an event if my dispatcher wants it. Previously, set in the event target, forwarding target, and source (if it wasn't already set)."

	anEvent hasSource ifFalse: [ anEvent source: self ].

	anEvent target: self.
	anEvent forwardingTarget: self.

	(self eventDispatcher wantsEvent: anEvent) ifTrue: [
		self eventDispatcher dispatchEvent: anEvent ]
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
					                    allParentsTo: eachPotentialParent
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
			host createHostSpaceFor: self.
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

{ #category : #'event management' }
BlSpace >> fireEvent: anEvent [
	"I fire provided event building an event dispatcher chain
	(from target to the root element) and dispatch the event with it."

	| aDispatcherChain |

	anEvent hasSource
		ifFalse: [ anEvent source: self ].

	anEvent target: self.

	aDispatcherChain := self buildEventDispatchChain: BlEventDispatcherChain empty.
	aDispatcherChain dispatchEvent: anEvent
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

{ #category : #'event management' }
BlSpace >> hasEventFilter: anEventHandler [
	^ self eventDispatcher hasFilter: anEventHandler
]

{ #category : #'event management' }
BlSpace >> hasEventHandler: anEventHandler [
	^ self eventDispatcher hasHandler: anEventHandler
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
	<return: #Boolean>

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

{ #category : #'event management accessing' }
BlSpace >> hasNextEventTarget [
	"Return true if this event target has a logical successor within a dispatch chain.
	For example, in case of visual components next event target is a parent, meaning
	that first event is handled by child and the dispatched to the parent if that event
	was not consumed"
	<return: #Boolean>

	^ false
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
	self hasHostSpace
		ifFalse: [ ^ anAbsentBlock value ].

	self hostSpace needsRebuild
		ifTrue: [ ^ anAbsentBlock value ].
		
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

	self updateCursor: Cursor normal.

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

{ #category : #'event management accessing' }
BlSpace >> nextEventTarget [
	"Return next event target that should be contained in dispatch chain.
	Note: returned object must use TBlEventTarget trait!"
	<return: #TBlEventTarget>

	self error: 'Override me if there is a next event target.'
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

{ #category : #'event management' }
BlSpace >> removeEventFilter: anEventHandler [
	self eventDispatcher removeEventFilter: anEventHandler
]

{ #category : #'event management' }
BlSpace >> removeEventFiltersSuchThat: aBlock [
	self eventDispatcher removeEventFiltersSuchThat: aBlock
]

{ #category : #'event management' }
BlSpace >> removeEventHandler: anEventHandler [
	self eventDispatcher removeEventHandler: anEventHandler
]

{ #category : #'event management' }
BlSpace >> removeEventHandlersSuchThat: aBlock [
	self eventDispatcher removeEventHandlersSuchThat: aBlock
]

{ #category : #'shortcut management' }
BlSpace >> removeShortcut: aShortcut [
	self eventDispatcher removeShortcut: aShortcut
]

{ #category : #'shortcut management' }
BlSpace >> removeShortcutsWithCombination: aBlKeyCombination [
	self eventDispatcher removeAllShortcutsWithCombination: aBlKeyCombination
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

{ #category : #'shortcut management' }
BlSpace >> shortcuts [
	<return: #BlShortcutRegistry>

	^ self eventDispatcher shortcutHandler shortcuts
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

{ #category : #'event management' }
BlSpace >> when: anEventClass doOnce: aBlock [
	"Add an event handler that will be removed right before culling the received block closure."

	self
		deprecated: 'Use addEventHandlerOn:doOnce: instead'
		transformWith: '`@receiver when: `@arg1 doOnce: `@arg2'
			-> '`@receiver addEventHandlerOn: `@arg1 doOnce: `@arg2'.

	^ self addEventHandlerOn: anEventClass doOnce: aBlock
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
