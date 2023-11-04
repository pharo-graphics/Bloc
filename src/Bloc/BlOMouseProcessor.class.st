"
I am a mouse event processor.
I convert basic events to more complex events.
For example, I generate events such as click, double-click or drag&drop, from more basic events such as mouse-down, mouse-up, and mouse-move.

Mouse actions are blocked during drag

"
Class {
	#name : 'BlOMouseProcessor',
	#superclass : 'BlBaseEventProcessor',
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
		'previousMouseDownEvent'
	],
	#category : 'Bloc-Space - Events'
}

{ #category : 'accessing' }
BlOMouseProcessor class >> dblClickDelay [
	<return: #Duration>
	^ 600 milliSeconds
]

{ #category : 'event testing' }
BlOMouseProcessor >> canBeClickEvent: aMouseUpEvent [
	^ dndInProgress not
		and: [ (previousMouseDownEvent isNotNil and: [ previousMouseDownEvent primaryButtonPressed ])
				and: [ aMouseUpEvent target = previousMouseDownEvent target ] ]
]

{ #category : 'event testing' }
BlOMouseProcessor >> canBeDblClickEvent: aMouseUpEvent [

	self flag: 'testing aMouseUpEvent target = lastClickEvent target is in fact needed, however, it breaks the Phlow list'.
	self flag: 'https://github.com/feenkcom/gtoolkit/issues/708'.

	^ lastClickEvent isNotNil
				and: [ aMouseUpEvent timestamp - lastClickEvent timestamp < self dblClickDelay ]
]

{ #category : 'event testing' }
BlOMouseProcessor >> canStartDrag: aMouseMoveEvent [
	<return: #Boolean>

	^ (pressedButtons includes: BlMouseButton primary)
		and: [ previousMouseDownEvent isNotNil
			and: [ previousMouseDownEvent primaryButtonPressed
				and: [ (aMouseMoveEvent position - previousMouseDownEvent position) r > self startDragThreshold ] ] ]
]

{ #category : 'accessing' }
BlOMouseProcessor >> dblClickDelay [
	^ self class dblClickDelay
]

{ #category : 'accessing' }
BlOMouseProcessor >> enteredTargets [
	<return: #Collection of: #BlElement>

	^ lastEnteredTargets
]

{ #category : 'event processing' }
BlOMouseProcessor >> fillTargetHierarchy: aTarget [
	^ Array streamContents: [ :aStream |
		aStream nextPut: aTarget.
		aTarget allParentsDo: [ :aParentElement | aStream nextPut: aParentElement  ] ]
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDragEndEvent: anEvent [

	self fireEvent:
			(anEvent asDragEndEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDragEnterEvent: anEvent targets: aCollection [
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

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDragEvent: anEvent [
	self	fireEvent:
			(anEvent asDragEvent
				startButtons: dragStartMask;
				target: currentDragTarget;
				gestureSource: currentDragTarget;
				dragboard: self space dragboard;
				yourself)
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDragLeaveEvent: anEvent targets: aCollection [
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

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDragStartEvent: anEvent [
	^ self fireEvent:
			(anEvent asDragStartEvent
				startButtons: dragStartMask;
				target: anEvent target;
				gestureSource: anEvent target;
				yourself)
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsDropEvent: anEvent [
	
	self	fireEvent:
			(anEvent asDropEvent
				gestureSource: currentDragTarget;
				gestureTarget: anEvent target;
				startButtons: dragStartMask;
				dragboard: self space dragboard;
				yourself)
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsEnterEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseEnterEvent
						target: t;
						canBePropagated: false;
						yourself)
					target: t ]
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsMouseLeaveEvent: anEvent targets: aCollection [
	aCollection
		do:	[ :t | 
			self dispatchEvent:
					(anEvent asMouseLeaveEvent
						target: t;
						canBePropagated: false;
						yourself)
					target:t ]
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsMouseOutEvent: aMouseEvent [
	self fireEvent: (aMouseEvent asMouseOutEvent target: lastOverTarget)
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsMouseOutEvent: aMouseEvent targets: aCollection [
	aCollection do: [ :eachElement |
		self fireEvent: (aMouseEvent asMouseOutEvent target: eachElement) ]
]

{ #category : 'event firing' }
BlOMouseProcessor >> fireAsMouseOverEvent: aMouseEvent [
	self fireEvent: aMouseEvent asMouseOverEvent 
]

{ #category : 'event processing' }
BlOMouseProcessor >> generateEvents [
	((lastEnteredTargets, { lastOverTarget }) reject: [ :eachElement | eachElement isNil or: [ eachElement space == self space ] ]) asSet
		ifNotEmpty: [ :removedEnteredTargets |
			| aMouseEvent |
			
			aMouseEvent := BlMouseEvent new
				button: (pressedButtons ifEmpty: [ nil ] ifNotEmpty: [ pressedButtons anyOne ]);
				position: 0@0;
				screenPosition: 0@0.
			
			self fireAsMouseLeaveEvent: aMouseEvent targets: removedEnteredTargets.
			self fireAsMouseOutEvent: aMouseEvent targets: removedEnteredTargets ].
	
	lastEnteredTargets := lastEnteredTargets select: [ :eachElement | eachElement isAttachedToSceneGraph ].
	(lastOverTarget notNil and: [ lastOverTarget space ~~ self space ])
		ifTrue: [ lastOverTarget := nil ].
	
	(self isMouseEventValid: previousMouseDownEvent)
		ifFalse: [ previousMouseDownEvent := nil ].

	(self isMouseEventValid: lastClickEvent)
		ifFalse: [ lastClickEvent := nil ]
]

{ #category : 'mouse down' }
BlOMouseProcessor >> handleMouseDown: aMouseDownEvent [
	| aTargetElement |

	"First we need to register a pressed button"
	self pressedButtons add: aMouseDownEvent button.

	aTargetElement := self processPicking: aMouseDownEvent.
	aMouseDownEvent target: aTargetElement.

	self fireEvent: aMouseDownEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aTargetElement.

	"store last mouse down event"
	previousMouseDownEvent := aMouseDownEvent
]

{ #category : 'mouse entered / left' }
BlOMouseProcessor >> handleMouseEntered: aSpaceMouseEnterEvent [
]

{ #category : 'mouse entered / left' }
BlOMouseProcessor >> handleMouseLeft: aSpaceMouseLeaveEvent [
	lastEnteredTargets do: [ :eachEnteredTarget |
		| anEvent |
		
		anEvent := self isDragging
			ifTrue: [ BlDragLeaveEvent new
				startButtons: dragStartMask;
				gestureSource: currentDragTarget ]
			ifFalse: [ BlMouseLeaveEvent new ].

		anEvent
			position: 0@0;
			target: eachEnteredTarget;
			canBePropagated: false;
			timestamp: self space time now.
		
		self dispatchEvent: anEvent target: eachEnteredTarget ].
	
	lastEnteredTargets := #().
	lastOverTarget := nil
]

{ #category : 'mouse move' }
BlOMouseProcessor >> handleMouseMove: aMouseMoveEvent [
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
			ifTrue: [ (self tryDragStart: previousMouseDownEvent)
				"we sent drag start, have to send first drag move"
				ifTrue: [ self processDragMove: aMouseMoveEvent ]
				"drag start was not handled, process as basic mouse move"
				ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
			"no need to even try to start a drag"
			ifFalse: [ self processMouseMove: aMouseMoveEvent ] ]
]

{ #category : 'mouse up' }
BlOMouseProcessor >> handleMouseUp: aMouseUpEvent [
	"DragEnd, Simple click and Dbl click"
	| aTargetElement |
	
	"if mouse button was not registered as pressed we can ignore this particular event"
	(self pressedButtons includes: aMouseUpEvent button)
		ifFalse: [ ^ self ].

	"we need to unregister a button"
	self pressedButtons remove: aMouseUpEvent button.

	aTargetElement := self processPicking: aMouseUpEvent.
	aMouseUpEvent target: aTargetElement.

	"depending on whether drag and drop is in process handle mouse up either
	as mouse up itself or as drag end event"
	self isDragging
		ifTrue: [ self processDragEnd: aMouseUpEvent ]
		ifFalse: [ self processMouseUp: aMouseUpEvent ]
]

{ #category : 'initialize-release' }
BlOMouseProcessor >> initialize [
	super initialize.
	lastEnteredTargets := #().
	dragStartMask := 0.
	dndInProgress := false.

	"a set of currently pressed mouse buttons button"
	pressedButtons := Set new.
	dragState := BlMouseDragState new
]

{ #category : 'testing' }
BlOMouseProcessor >> isDragging [
	"Return true if drag and drop is in process, false otherwise"
	<return: #Boolean>
	
	^ dndInProgress
]

{ #category : 'private' }
BlOMouseProcessor >> isMouseEventValid: anEvent [

	anEvent ifNil: [ ^ false ].
	(({ 
		  anEvent target.
		  anEvent currentTarget.
		  anEvent source } reject: [ :eachElement | eachElement isNil ]) 
		 anySatisfy: [ :eachTargetElement | 
		 eachTargetElement space ~~ self space ]) ifTrue: [ ^ false ].

	^ true
]

{ #category : 'event testing' }
BlOMouseProcessor >> isValidDragTarget: aEvent [
	^ (aEvent target = self space root) not
]

{ #category : 'accessing' }
BlOMouseProcessor >> lastClickEvent [
	<return: #BlClickEvent or: nil>

	^ lastClickEvent
]

{ #category : 'accessing' }
BlOMouseProcessor >> lastMouseDownEvent [
	<return: #BlElement or: nil>

	^ previousMouseDownEvent
]

{ #category : 'accessing' }
BlOMouseProcessor >> lastOverTarget [
	<return: #BlElement>

	^ lastOverTarget
]

{ #category : 'initialize-release' }
BlOMouseProcessor >> onSpaceClosed [
	lastEnteredTargets := #().
	lastOverTarget := nil.
	lastClickEvent := nil.
	currentDragTarget := nil.
	lastMouseTarget := nil.
	dndInProgress := nil.
	dragStartMask := 0.
	pressedButtons := Set new.
	previousMouseDownEvent := nil
]

{ #category : 'event processing' }
BlOMouseProcessor >> postProcess: aMouseEvent [
	
]

{ #category : 'event processing' }
BlOMouseProcessor >> preProcess: aMouseEvent [
	| aTarget |
	
	aTarget := self processPicking: aMouseEvent.

	aMouseEvent target: aTarget.

	"mouse move is only fired when no dnd is in progress (else it is a drag event)"
	dndInProgress ifFalse: [ self fireEvent: aMouseEvent ].
	"now we can update the cursor from the target"
	self updateCursorFrom: aTarget
]

{ #category : 'accessing' }
BlOMouseProcessor >> pressedButtons [
	"Return a collection of currently pressed mouse buttons"
	<return: #Collection of: #BlMouseButton>

	^ pressedButtons
]

{ #category : 'mouse drag' }
BlOMouseProcessor >> processDragEnd: aMouseUpEvent [

	self
		assert: [ self isDragging ]
		description: [ 'Can not process mouse up event as drag end if I am not in dragging state' ].
		
	self
		assert: [ currentDragTarget isNotNil ]
		description: [ 'When we drag something it can not be nil' ].

	aMouseUpEvent primaryButtonPressed
		ifTrue: [ 
			self fireAsDragEndEvent: aMouseUpEvent.
			self fireAsDropEvent: aMouseUpEvent.
						
			currentDragTarget := nil.
			dndInProgress := false.
			lastOverTarget := nil.
			dragStartMask := 0 ]
]

{ #category : 'mouse drag' }
BlOMouseProcessor >> processDragMove: aMouseMoveEvent [

	"check drag"
	self fireAsDragEvent: aMouseMoveEvent.

	"dragstart/drag events management"
	currentDragTarget ifNotNil: [ self subprocessDragEnterExitEvent: aMouseMoveEvent ].
	
	"update last overed target"
	lastOverTarget := aMouseMoveEvent target
]

{ #category : 'mouse move' }
BlOMouseProcessor >> processMouseEnterLeaveEvent: aMouseEvent [
	| newLeavedTargets newEnteredTargets currentEnteredTargets |

	"mouse is moved over the same element, no need to process enter/leave events"
	lastOverTarget = aMouseEvent target
		ifTrue: [ ^ self ].

	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	"fire mouseout to the previous overed target"
	lastOverTarget isNotNil
		ifTrue: [ self fireAsMouseOutEvent: aMouseEvent ].
	
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

{ #category : 'mouse move' }
BlOMouseProcessor >> processMouseMove: aMouseMoveEvent [
	self processMouseEnterLeaveEvent: aMouseMoveEvent.

	self fireEvent: aMouseMoveEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aMouseMoveEvent target.
	
]

{ #category : 'event handling entrypoint' }
BlOMouseProcessor >> processMouseScroll: aMouseScrollEvent [
	"picking and mouse move"
	self preProcess: aMouseScrollEvent.
	"does nothing for the moment"
	self postProcess: aMouseScrollEvent
]

{ #category : 'mouse up' }
BlOMouseProcessor >> processMouseUp: aMouseUpEvent [

	self fireEvent: aMouseUpEvent.

	self updateCursorFrom: aMouseUpEvent target.

	(self canBeClickEvent: aMouseUpEvent)
		ifTrue: [ 
			(self canBeDblClickEvent: aMouseUpEvent)
				ifTrue: [ 
					lastClickEvent := nil.
					self fireEvent: aMouseUpEvent asDoubleClickEvent ]
				ifFalse: [ 
					| aClickEvent |
					aClickEvent := aMouseUpEvent asClickEvent.
					self fireEvent: aClickEvent.
					lastClickEvent := aClickEvent copy ] ]
]

{ #category : 'event processing' }
BlOMouseProcessor >> processPicking: aMouseEvent [

	<return: #BlElement>
	| aTargetElement |
	(lastOverTarget isNotNil and: [ 
		 lastOverTarget isAttachedToSceneGraph not ]) ifTrue: [ 
		lastOverTarget := nil ].

	"if the last over target contains the point we can start picking from it"
	aTargetElement := (aMouseEvent isMouseMove and: [ 
		                   lastOverTarget isNotNil and: [ 
			                   lastOverTarget containsGlobalPoint:
				                   aMouseEvent position ] ])
		                  ifTrue: [ lastOverTarget findMouseEventTargetAt: aMouseEvent position ]
		                  ifFalse: [ self space findMouseEventTargetAt: aMouseEvent position ].
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement
]

{ #category : 'accessing' }
BlOMouseProcessor >> startDragThreshold [
	^ 4
]

{ #category : 'mouse drag' }
BlOMouseProcessor >> subprocessDragEnterExitEvent: aMouseEvent [
	| newEnteredTargets newExitedTargets currentEnteredTargets |

	self 
		assert: [ currentDragTarget isNotNil ]
		description: [ 'Can not process drag mouse event as enter / exit when there is no dragged element' ].
	
	currentEnteredTargets := self fillTargetHierarchy: aMouseEvent target.
	
	lastOverTarget = aMouseEvent target ifFalse:[
		newExitedTargets := lastEnteredTargets reject: [ :anElement | currentEnteredTargets includes: anElement ].
		newEnteredTargets := currentEnteredTargets reject: [ :anElement | lastEnteredTargets includes: anElement ].
		self fireAsDragLeaveEvent: aMouseEvent targets: newExitedTargets.
		self fireAsDragEnterEvent: aMouseEvent targets: newEnteredTargets ].
	
	"store last entered targets"
	lastEnteredTargets := currentEnteredTargets
]

{ #category : 'mouse drag' }
BlOMouseProcessor >> tryDragStart: aMouseEvent [
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

{ #category : 'event processing' }
BlOMouseProcessor >> updateCursorFrom: aTarget [
	| t |
	t := aTarget.
	[ t mouseCursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t mouseCursor
		ifTrue: [ ^ self ].
	self space currentCursor: t mouseCursor
]

{ #category : 'event processing' }
BlOMouseProcessor >> updateDragView [

]

{ #category : 'event processing' }
BlOMouseProcessor >> updateFocusOwner: aNode [
	
]
