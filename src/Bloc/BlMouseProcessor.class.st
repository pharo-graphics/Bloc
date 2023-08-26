Class {
	#name : #BlMouseProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'lastEnteredTargets',
		'lastOverTarget',
		'lastClickEvent',
		'currentDragTarget',
		'lastMouseTarget',
		'dndInProgress',
		'dragStartMask',
		'pressedButtons',
		'dragState',
		'lastMouseMoveEvent',
		'lastMouseDownEvent'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #accessing }
BlMouseProcessor class >> dblClickDelay [
	<return: #Duration>
	^ 400 milliSeconds
]

{ #category : #'event testing' }
BlMouseProcessor >> canBeClickAvortedEvent: aMouseUpEvent [

	^ lastMouseDownEvent isNotNil and: [
		  aMouseUpEvent target ~= lastMouseDownEvent target ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canBeClickEvent: aMouseUpEvent [

	^ dndInProgress not and: [
		  lastMouseDownEvent isNotNil and: [
			  aMouseUpEvent target = lastMouseDownEvent target ] ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canBeDblClickEvent: aMouseUpEvent [

	self flag: 'testing aMouseUpEvent target = lastClickEvent target is in fact needed, however, it breaks the Phlow list'.
	self flag: 'https://github.com/feenkcom/gtoolkit/issues/708'.

	^ lastClickEvent isNotNil and: [  aMouseUpEvent target = lastClickEvent target
				and: [ aMouseUpEvent timestamp - lastClickEvent timestamp < self dblClickDelay ] ]
]

{ #category : #'event testing' }
BlMouseProcessor >> canStartDrag: aMouseMoveEvent [
	<return: #Boolean>

	^ (pressedButtons includes: BlMouseButton primary)
		and: [ lastMouseDownEvent isNotNil
			and: [ lastMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - lastMouseDownEvent position) r > self startDragThreshold ] ] ]
]

{ #category : #'event processing' }
BlMouseProcessor >> checkLastOverTarget [

	lastOverTarget ifNil: [ ^ self ].
	lastOverTarget isAttachedToSceneGraph ifTrue: [ ^ self ].
	lastOverTarget := nil
]

{ #category : #accessing }
BlMouseProcessor >> dblClickDelay [
	^ self class dblClickDelay
]

{ #category : #'event firing' }
BlMouseProcessor >> dispatchEvent: anEvent target: aTarget [

	" enter/leave events are dispatched to a known target "
	super dispatchEvent: anEvent target: aTarget
]

{ #category : #accessing }
BlMouseProcessor >> enteredTargets [
	<return: #Collection of: #BlElement>

	^ lastEnteredTargets
]

{ #category : #'event processing' }
BlMouseProcessor >> fillTargetHierarchy: aTarget [
	^ Array streamContents: [ :aStream |
		aStream nextPut: aTarget.
		aTarget allParentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEndEvent: anEvent [

	self fireEvent:
			(anEvent asDragEndEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEnterEvent: anEvent targets: aCollection [
	aCollection
		do: [ :t | 
			self dispatchEvent:
					(anEvent asDragEnterEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
				target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragEvent: anEvent [
	self	fireEvent:
			(anEvent asDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asDragLeaveEvent
						startButtons: dragStartMask;
						target: t;
						gestureSource: currentDragTarget;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDragStartEvent: anEvent [
	^ self fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: anEvent target;
				gestureSource: anEvent target;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsDropEvent: anEvent [
	
	self	fireEvent:
			(anEvent asDropEvent
				gestureSource: currentDragTarget;
				gestureTarget: anEvent target;
				startButtons: dragStartMask;
				dragboard: self space dragboard;
				yourself)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsEnterEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseEnterEvent
						target: t;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseLeaveEvent
						target: t;
						canBePropagated: false;
						yourself)
					target:t ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent [

	self fireEvent: (aMouseEvent asMouseOutEvent target: lastOverTarget)
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOutEvent: aMouseEvent targets: aCollection [
	aCollection do: [ :eachElement |
		self fireEvent: (aMouseEvent asMouseOutEvent target: eachElement) ]
]

{ #category : #'event firing' }
BlMouseProcessor >> fireAsMouseOverEvent: aMouseEvent [
	self fireEvent: aMouseEvent asMouseOverEvent 
]

{ #category : #'mouse up' }
BlMouseProcessor >> fireClickAvortedEventFrom: aMouseUpEvent [
	"Click avorted is useful to let the mouse down target decide if it can be a click or not "

	lastMouseDownEvent target fireEvent: (BlClickAvortedEvent new
			 copyFrom: lastMouseDownEvent;
			 upEvent: aMouseUpEvent;
			 processor: self;
			 yourself)
]

{ #category : #'mouse up' }
BlMouseProcessor >> fireClickEventFrom: aMouseEvent [

	| aClickEvent |
	aClickEvent := aMouseEvent asClickEvent.
	self fireEvent: aClickEvent.
	lastClickEvent := aClickEvent copy
]

{ #category : #'event firing' }
BlMouseProcessor >> fireEvent: anEvent [

	" for events other than entre/leave "
	^ super fireEvent: anEvent
]

{ #category : #'event processing' }
BlMouseProcessor >> generateEvents [

	(lastEnteredTargets , { lastOverTarget } reject: [ :eachElement |
		 eachElement isNil or: [ eachElement space == self space ] ]) asSet
		ifNotEmpty: [ :removedEnteredTargets |
			| aMouseEvent |
			aMouseEvent := BlMouseEvent new
				               button:
					               (pressedButtons
						                ifEmpty: [ nil ]
						                ifNotEmpty: [ pressedButtons anyOne ]);
				               position: 0 @ 0;
				               screenPosition: 0 @ 0.

			self
				fireAsMouseLeaveEvent: aMouseEvent
				targets: removedEnteredTargets.
			self
				fireAsMouseOutEvent: aMouseEvent
				targets: removedEnteredTargets ].

	lastEnteredTargets := lastEnteredTargets select: [ :eachElement |
		                      eachElement isAttachedToSceneGraph ].

	(lastOverTarget notNil and: [ lastOverTarget space ~~ self space ])
		ifTrue: [ lastOverTarget := nil ].

	(self isMouseEventValid: lastMouseDownEvent) ifFalse: [
		lastMouseDownEvent := nil ].

	(self isMouseEventValid: lastClickEvent) ifFalse: [
		lastClickEvent := nil ]
]

{ #category : #'mouse move' }
BlMouseProcessor >> handleLastMouseMove [

	| target |
	lastMouseMoveEvent ifNil: [ ^ self ].
	target := self processPicking: lastMouseMoveEvent.	
	lastMouseMoveEvent target: target.
	lastMouseMoveEvent button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]).
	self processMouseMove: lastMouseMoveEvent.
]

{ #category : #'mouse down' }
BlMouseProcessor >> handleMouseDown: aMouseDownEvent [
	| aTargetElement |

	"First we need to register a pressed button"
	self pressedButtons add: aMouseDownEvent button.

	aTargetElement := self processPicking: aMouseDownEvent.

	aMouseDownEvent target: aTargetElement.

	self fireEvent: aMouseDownEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aTargetElement.

	"store last mouse down event"
	lastMouseDownEvent := aMouseDownEvent
]

{ #category : #'mouse entered / left' }
BlMouseProcessor >> handleMouseEntered: aSpaceMouseEnterEvent [
]

{ #category : #'mouse entered / left' }
BlMouseProcessor >> handleMouseLeft: aSpaceMouseLeaveEvent [

	lastEnteredTargets do: [ :eachEnteredTarget |
		| anEvent |
		anEvent := self isDragging
			           ifTrue: [
				           BlDragLeaveEvent new
					           startButtons: dragStartMask;
					           gestureSource: currentDragTarget ]
			           ifFalse: [ BlMouseLeaveEvent new ].

		anEvent
			position: 0 @ 0;
			target: eachEnteredTarget;
			canBePropagated: false;
			timestamp: self space time now.

		self dispatchEvent: anEvent target: eachEnteredTarget ].

	lastEnteredTargets := #(  ).
	lastOverTarget := nil
]

{ #category : #'mouse move' }
BlMouseProcessor >> handleMouseMove: aMouseMoveEvent [
	| aTargetElement shouldTryDragStart |
	"picking and mouse move"
	
	aTargetElement := self processPicking: aMouseMoveEvent.
	self
		assert: [ aTargetElement isAttachedToSceneGraph ]
		description: [ 'Target element must be attached to the scene graph' ].
	
	aMouseMoveEvent target: aTargetElement.
	aMouseMoveEvent button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]).

	shouldTryDragStart := self isDragging
		ifFalse: [ (self canStartDrag: aMouseMoveEvent) ]
		ifTrue: [ false ].

	self isDragging
		"we are dragging, handle it as drag move"
		ifTrue: [ self processDragMove: aMouseMoveEvent ]
		ifFalse: [ shouldTryDragStart
			ifTrue: [ (self tryDragStart: lastMouseDownEvent)
				"we sent drag start, have to send first drag move"
				ifTrue: [ self processDragMove: aMouseMoveEvent ]
				"drag start was not handled, process as basic mouse move"
				ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
			"no need to even try to start a drag"
			ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
]

{ #category : #'mouse up' }
BlMouseProcessor >> handleMouseUp: aMouseUpEvent [
	"DragEnd, Simple click and Dbl click"
	| aTargetElement |
	
	"if mouse button was not registered as pressed we can ignore this particular event"
	(self pressedButtons includes: aMouseUpEvent button)
		ifFalse: [ ^ self ].

	"we need to unregister a button"
	self pressedButtons remove: aMouseUpEvent button.
	
	"Note that the element that receives mouseup can be different from the element that received mousedown (lastMouseDownEvent)"
	aTargetElement := self processPicking: aMouseUpEvent.
	aMouseUpEvent target: aTargetElement.

	"depending on whether drag and drop is in process handle mouse up either
	as mouse up itself or as drag end event"
	self isDragging
		ifTrue: [ self processDragEnd: aMouseUpEvent ]
		ifFalse: [ self processMouseUp: aMouseUpEvent ]
]

{ #category : #initialization }
BlMouseProcessor >> initialize [

	super initialize.
	self reset
]

{ #category : #testing }
BlMouseProcessor >> isDragging [
	"Return true if drag and drop is in process, false otherwise"
	<return: #Boolean>
	
	^ dndInProgress
]

{ #category : #private }
BlMouseProcessor >> isMouseEventValid: anEvent [

	anEvent ifNil: [ ^ false ].
	(({ 
		  anEvent target.
		  anEvent currentTarget.
		  anEvent source } reject: [ :eachElement | eachElement isNil ]) 
		 anySatisfy: [ :eachTargetElement | 
		 eachTargetElement space ~~ self space ]) ifTrue: [ ^ false ].

	^ true
]

{ #category : #'event testing' }
BlMouseProcessor >> isValidDragTarget: aEvent [

	^ (aEvent target = self space root) not
]

{ #category : #accessing }
BlMouseProcessor >> lastClickEvent [
	<return: #BlClickEvent or: nil>

	^ lastClickEvent
]

{ #category : #accessing }
BlMouseProcessor >> lastMouseDownEvent [
	<return: #BlElement or: nil>

	^ lastMouseDownEvent
]

{ #category : #accessing }
BlMouseProcessor >> lastMouseMoveEvent [

	^ lastMouseMoveEvent
]

{ #category : #accessing }
BlMouseProcessor >> lastOverTarget [
	<return: #BlElement>

	^ lastOverTarget
]

{ #category : #'initialize-release' }
BlMouseProcessor >> onSpaceClosed [
	
	self reset
]

{ #category : #'event processing' }
BlMouseProcessor >> postProcess: aMouseEvent [
	
]

{ #category : #'event processing' }
BlMouseProcessor >> preProcess: aMouseEvent [
	| aTarget |
	
	aTarget := self processPicking: aMouseEvent.

	aMouseEvent target: aTarget.

	"mouse move is only fired when no dnd is in progress (else it is a drag event)"
	dndInProgress ifFalse: [ self fireEvent: aMouseEvent ].
	"now we can update the cursor from the target"
	self updateCursorFrom: aTarget
]

{ #category : #accessing }
BlMouseProcessor >> pressedButtons [
	"Return a collection of currently pressed mouse buttons"
	<return: #Collection of: #BlMouseButton>

	^ pressedButtons
]

{ #category : #'mouse drag' }
BlMouseProcessor >> processDragEnd: aMouseUpEvent [

	self assert: [ self isDragging ] description: [
		'Can not process mouse up event as drag end if I am not in dragging state' ].
	self
		assert: [ currentDragTarget isNotNil ]
		description: [ 'When we drag something it can not be nil' ].

	aMouseUpEvent primaryButtonPressed ifFalse: [ ^ self ].
	self fireAsDragEndEvent: aMouseUpEvent.
	self fireAsDropEvent: aMouseUpEvent.
	currentDragTarget := nil.
	dndInProgress := false.
	lastOverTarget := nil.
	dragStartMask := 0
]

{ #category : #'mouse drag' }
BlMouseProcessor >> processDragMove: aMouseMoveEvent [

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].
	
	"update last overed target"
	lastOverTarget := aMouseMoveEvent target
]

{ #category : #'mouse move' }
BlMouseProcessor >> processMouseEnterLeaveEvent: aMouseEvent [
	| newLeavedTargets newEnteredTargets currentEnteredTargets |

	"mouse is moved over the same element, no need to process enter/leave events"
	lastOverTarget = aMouseEvent target
		ifTrue: [ ^ self ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	"fire mouseout to the previous overed target"
	lastOverTarget ifNotNil: [ self fireAsMouseOutEvent: aMouseEvent ].
	
	"fire mouse leave events"
	newLeavedTargets := lastEnteredTargets reject: [ :anElement | (currentEnteredTargets includes: anElement) ].
	newLeavedTargets := newLeavedTargets select: #isAttachedToSceneGraph.

	self fireAsMouseLeaveEvent: aMouseEvent targets: newLeavedTargets.
	
	"fire mouse event to the current target"
	self fireAsMouseOverEvent: aMouseEvent.
	
	"fire enter events"
	newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
	self fireAsEnterEvent: aMouseEvent targets: newEnteredTargets.

	lastOverTarget := aMouseEvent target.
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse move' }
BlMouseProcessor >> processMouseMove: aMouseMoveEvent [

	lastMouseMoveEvent := aMouseMoveEvent.

	self processMouseEnterLeaveEvent: aMouseMoveEvent.

	self fireEvent: aMouseMoveEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aMouseMoveEvent target.
	
]

{ #category : #'event handling entrypoint' }
BlMouseProcessor >> processMouseScroll: aMouseScrollEvent [
	"picking and mouse move"
	self preProcess: aMouseScrollEvent.
	"does nothing for the moment"
	self postProcess: aMouseScrollEvent
]

{ #category : #'mouse up' }
BlMouseProcessor >> processMouseUp: aMouseUpEvent [

	self fireEvent: aMouseUpEvent.

	self updateCursorFrom: aMouseUpEvent target.

	(self canBeClickEvent: aMouseUpEvent)
		ifTrue: [
			(self canBeDblClickEvent: aMouseUpEvent)
				ifTrue: [ self fireEvent: aMouseUpEvent asDoubleClickEvent ]
				ifFalse: [ self fireClickEventFrom: aMouseUpEvent ] ]
		ifFalse: [ 
			(self canBeClickAvortedEvent: aMouseUpEvent) ifTrue: [
				self fireClickAvortedEventFrom: aMouseUpEvent ] ]
]

{ #category : #'mouse picking' }
BlMouseProcessor >> processPicking: aMouseEvent [
	" return the element at event position "

	| aTargetElement |
	" check if the last overtarget is still valid "
	self checkLastOverTarget.

	"if the last over target contains the point we can start picking from it (speed-up picking a lot)"
	"aTargetElement := (aMouseEvent canFindTargetFrom: lastOverTarget)
		                  ifTrue: [ aMouseEvent findTargetFrom: lastOverTarget ]
		                  ifFalse: [ aMouseEvent findTargetFrom: self space ]."
	self flag: 'always pick element starting from space because of menu'.
	aTargetElement := aMouseEvent findTargetFrom: self space.
	"we have to ensure that aTarget is not nil"
	^ aTargetElement ifNil: [ aTargetElement := self space root ]
]

{ #category : #'initialize-release' }
BlMouseProcessor >> reset [

	lastEnteredTargets := #().
	lastOverTarget := nil.
	lastClickEvent := nil.
	currentDragTarget := nil.
	lastMouseTarget := nil.
	dndInProgress := false.
	dragStartMask := 0.
	pressedButtons := Set new.
	dragState := BlMouseDragState new
]

{ #category : #accessing }
BlMouseProcessor >> startDragThreshold [
	^ 4
]

{ #category : #'mouse drag' }
BlMouseProcessor >> subprocessDragEnterExitEvent: aMouseEvent [

	| newEnteredTargets newExitedTargets currentEnteredTargets |

	self assert: [ currentDragTarget isNotNil ] description: [
		'Can not process drag mouse event as enter / exit when there is no dragged element' ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.

	lastOverTarget = aMouseEvent target ifFalse: [
		newExitedTargets := lastEnteredTargets reject: [ :anElement |
			                    currentEnteredTargets includes: anElement ].
		newEnteredTargets := currentEnteredTargets reject: [ :anElement |
			                     lastEnteredTargets includes: anElement ].
		self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
		self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets ].

	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets
]

{ #category : #'mouse drag' }
BlMouseProcessor >> tryDragStart: aMouseEvent [
	"Try to start a drag and return true if drag actually started, otherwise false"
	<return: #Boolean>
	| aDragTarget aDragStartEvent |
	
	aDragTarget := aMouseEvent target.
	
	aDragStartEvent := (aMouseEvent asDragStartEvent
		startButtons: dragStartMask;
		target: aDragTarget;
		gestureSource: aDragTarget;
		yourself).

	aDragStartEvent := self fireEvent: aDragStartEvent.
	
	currentDragTarget := aDragStartEvent isConsumed
		ifTrue: [ aDragStartEvent currentTarget ]
		ifFalse: [ nil ].

	^ dndInProgress := aDragStartEvent isConsumed
]

{ #category : #'event processing' }
BlMouseProcessor >> updateCursorFrom: aTarget [
	| t |
	t := aTarget.
	[ t mouseCursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t mouseCursor
		ifTrue: [ ^ self ].
	self space currentCursor: t mouseCursor
]

{ #category : #'event processing' }
BlMouseProcessor >> updateDragView [

]

{ #category : #'event processing' }
BlMouseProcessor >> updateFocusOwner: aNode [
	
]
