"
The specific announcement superclass for the context of Bloc.
"
Class {
	#name : #BlEvent,
	#superclass : #Announcement,
	#instVars : [
		'target',
		'source',
		'currentTarget',
		'timestamp',
		'canBePropagated',
		'consumed',
		'traversedTargets'
	],
	#category : #'Bloc-Events'
}

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent [
	<return: #BlEvent>

	^ self fireEvent: anEvent target: anEvent target
]

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent target: anEventTarget [
	<return: #BlEvent>
	| theEvent aDispatcherChain |

	theEvent := anEvent.

	anEvent hasSource
		ifFalse: [ anEvent source: anEventTarget ].

	anEvent target = anEventTarget
		ifFalse: [ theEvent := anEvent newCopyFor: anEventTarget].

	aDispatcherChain := anEventTarget buildEventDispatchChain: BlEventDispatcherChain empty.
	^ aDispatcherChain dispatchEvent: theEvent
]

{ #category : #'private - steps' }
BlEvent >> arrivedTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalTargetStep new target: currentTarget)
]

{ #category : #'private - steps' }
BlEvent >> bubblingTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalBubblingStep new target: currentTarget)
]

{ #category : #testing }
BlEvent >> canBePropagated [
	^ canBePropagated ifNil: [ canBePropagated := true ]
]

{ #category : #'private - accessing' }
BlEvent >> canBePropagated: anObject [
	canBePropagated := anObject
]

{ #category : #'private - steps' }
BlEvent >> capturingTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalCapturingStep new target: currentTarget)
]

{ #category : #testing }
BlEvent >> consumed: aBoolean [
	consumed := aBoolean
]

{ #category : #copying }
BlEvent >> copyFrom: anEvent [
	super copyFrom: anEvent.

	"We re-initialize traversed targets in order to support event convertion like #asClickEvent
	because the event that we are copying from might have already other traversed targets"
	traversedTargets := LinkedList new.
	"new copies are not consumed yet"
	consumed := false
]

{ #category : #'api - accessing' }
BlEvent >> currentTarget [
	"Identifies the current target for the event, as the event traverses the scene graph.
	It always refers to the element to which the event handler has been attached, as opposed to #target which identifies the element on which the event occurred."
	<return: #TBlEventTarget>

	^ currentTarget
]

{ #category : #'api - accessing' }
BlEvent >> currentTarget: anEventTarget [
	currentTarget := anEventTarget
]

{ #category : #firing }
BlEvent >> fire [
	BlEvent fireEvent: self
]

{ #category : #'private - steps' }
BlEvent >> forwardingTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget.	
	self traversedTargets add: (BlEventTraversalForwardingStep new target: currentTarget)
]

{ #category : #testing }
BlEvent >> hasSource [
	<return: #Boolean>
	
	^ source isNotNil
]

{ #category : #initialization }
BlEvent >> initialize [
	super initialize.
	
	traversedTargets := LinkedList new
]

{ #category : #testing }
BlEvent >> isBaseDrag [
	^ false
]

{ #category : #testing }
BlEvent >> isBaseFocus [
	^ false
]

{ #category : #testing }
BlEvent >> isBlur [
	^ false
]

{ #category : #testing }
BlEvent >> isClick [
	^ false
]

{ #category : #testing }
BlEvent >> isConsumed [
	^ consumed ifNil: [ consumed := false ]
]

{ #category : #testing }
BlEvent >> isDoubleClick [
	^ false
]

{ #category : #testing }
BlEvent >> isDrag [
	^ false
]

{ #category : #testing }
BlEvent >> isFocus [
	^ false
]

{ #category : #testing }
BlEvent >> isFocusIn [
	^ false
]

{ #category : #testing }
BlEvent >> isFocusOut [
	^ false
]

{ #category : #testing }
BlEvent >> isFocusTransfer [
	^ false
]

{ #category : #testing }
BlEvent >> isGesture [
	^ false
]

{ #category : #testing }
BlEvent >> isKeyboard [
	^ false
]

{ #category : #testing }
BlEvent >> isMouse [
	^ false
]

{ #category : #testing }
BlEvent >> isMouseDown [
	^ false
]

{ #category : #testing }
BlEvent >> isMouseEnter [
	^ false
]

{ #category : #testing }
BlEvent >> isMouseLeave [
	^ false
]

{ #category : #testing }
BlEvent >> isMouseMove [
	^ false
]

{ #category : #testing }
BlEvent >> isMouseUp [
	^ false
]

{ #category : #testing }
BlEvent >> isSpaceEvent [
	^ false
]

{ #category : #testing }
BlEvent >> isTextInput [
	^ false
]

{ #category : #testing }
BlEvent >> isTouch [
	^ false
]

{ #category : #testing }
BlEvent >> isUniverseEvent [
	^ false
]

{ #category : #firing }
BlEvent >> newCopyFor: aTarget [
	^ self class new
		copyFrom: self;
		target: aTarget;
		yourself
]

{ #category : #copying }
BlEvent >> postCopy [
	super postCopy.
	
	traversedTargets := traversedTargets copy
]

{ #category : #sending }
BlEvent >> sendTo: anObject [
	
]

{ #category : #accessing }
BlEvent >> source [
	"Return an event target that plays a role of a source of this event"

	self
		assert: [ self hasSource ]
		description: [ 'Can not access a source if there is no one' ].

	^ source
]

{ #category : #accessing }
BlEvent >> source: aBlEventTarget [	
	source := aBlEventTarget
]

{ #category : #'api - accessing' }
BlEvent >> target [
	"Return a reference to the object that dispatched the event.
	It is different from #currentTarget when the event handler is called during the bubbling or capturing phase of the event."
	<return: #TBlEventTarget>

	^ target
]

{ #category : #'private - accessing' }
BlEvent >> target: aTBlEventTarget [
	target := aTBlEventTarget
]

{ #category : #'api - accessing' }
BlEvent >> timestamp [
	"Returns the time at which the event was created."
	<return: #DateAndTime>

	^ timestamp
]

{ #category : #'private - accessing' }
BlEvent >> timestamp: aDateAndTime [

	self
		assert: [ aDateAndTime isNumber not ]
		description: [ 'Number can not be used as a timestamp, use DateAndTime instead' ].

	timestamp := aDateAndTime
]

{ #category : #'api - accessing' }
BlEvent >> traversedTargets [
	^ traversedTargets
]
