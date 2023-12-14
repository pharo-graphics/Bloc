"
Bloc's root announcement class. I have many subclasses representing concrete event types:
```
BlEvent allSubclasses
```

"
Class {
	#name : 'BlEvent',
	#superclass : 'Announcement',
	#instVars : [
		'target',
		'source',
		'currentTarget',
		'timestamp',
		'canBePropagated',
		'consumed'
	],
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'api - enable / disable' }
BlEvent class >> disableIn: anEventDispatcher [
	anEventDispatcher disableGeneralEventType: self
]

{ #category : 'api - enable / disable' }
BlEvent class >> enableIn: anEventDispatcher [
	anEventDispatcher enableGeneralEventType: self
]

{ #category : 'event management' }
BlEvent class >> fireEvent: anEvent [
	<return: #BlEvent>

	^ self fireEvent: anEvent target: anEvent target
]

{ #category : 'event management' }
BlEvent class >> fireEvent: anEvent from: aTopEventTarget [
	<return: #BlEvent>

	^ self fireEvent: anEvent from: aTopEventTarget to: anEvent target
]

{ #category : 'event management' }
BlEvent class >> fireEvent: anEvent from: aTopEventTarget to: aTargetEventTarget [
	<return: #BlEvent>
	| theEvent aDispatcherChain |

	theEvent := anEvent.

	anEvent hasSource
		ifFalse: [ anEvent source: aTargetEventTarget ].

	anEvent target = aTargetEventTarget
		ifFalse: [ theEvent := anEvent newCopyFor: aTargetEventTarget].

	aDispatcherChain := aTargetEventTarget buildEventDispatchChain: BlEventDispatcherChain empty upTo: aTopEventTarget.
	^ aDispatcherChain dispatchEvent: theEvent
]

{ #category : 'event management' }
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

{ #category : 'accessing' }
BlEvent class >> from: anEventTarget [
	^ self new
		target: anEventTarget;
		source: anEventTarget;
		yourself
]

{ #category : 'accessing' }
BlEvent class >> target: anObject [
	^ self new
		target: anObject;
		yourself
]

{ #category : 'private' }
BlEvent class >> targetToDictionaryForExport: anObject [
	| aDictionary |

	aDictionary := OrderedDictionary new 
		at: #class put: anObject class name;
		at: #hash put: anObject identityHash;
		yourself.

	(anObject respondsTo: #id)
		ifTrue: [ aDictionary at: #id put: anObject id asString ].

	^ aDictionary
]

{ #category : 'api - enable / disable' }
BlEvent class >> wantedIn: anEventDispatcher [
	^ anEventDispatcher wantsGeneralEventType: self
]

{ #category : 'private - steps' }
BlEvent >> arrivedTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : 'converting' }
BlEvent >> asDictionaryForExport [
	^ OrderedDictionary new 
		at: #event put: self class name;
		at: #source put: (source ifNotNil: [ :aSource | self class targetToDictionaryForExport: aSource ]);
		at: #target put: (target ifNotNil: [ :aTarget | self class targetToDictionaryForExport: aTarget ]);
		at: #currentTarget put: (currentTarget ifNotNil: [ :aCurrentTarget | self class targetToDictionaryForExport: aCurrentTarget ]);
		at: #timestamp put: timestamp asString;
		at: #canBePropagated put: canBePropagated;
		at: #consumed put: consumed;
		yourself
]

{ #category : 'private - steps' }
BlEvent >> bubblingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : 'testing' }
BlEvent >> canBePropagated [
	<return: #Boolean>

	^ canBePropagated
]

{ #category : 'private - accessing' }
BlEvent >> canBePropagated: anObject [
	canBePropagated := anObject
]

{ #category : 'private - steps' }
BlEvent >> capturingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : 'testing' }
BlEvent >> consumed: aBoolean [
	consumed := aBoolean
]

{ #category : 'copying' }
BlEvent >> copyFrom: anEvent [
	super copyFrom: anEvent.

	"new copies are not yet consumed"
	consumed := false
]

{ #category : 'api - accessing' }
BlEvent >> currentTarget [
	"Identifies the current target for the event, as the event traverses the scene graph.
	It always refers to the element to which the event handler has been attached, as opposed to #target which identifies the element on which the event occurred."
	<return: #TBlEventTarget>

	^ currentTarget
]

{ #category : 'api - accessing' }
BlEvent >> currentTarget: anEventTarget [
	currentTarget := anEventTarget
]

{ #category : 'firing' }
BlEvent >> fire [
	BlEvent fireEvent: self
]

{ #category : 'private - steps' }
BlEvent >> forwardingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : 'testing' }
BlEvent >> hasSource [
	<return: #Boolean>
	
	^ source isNotNil
]

{ #category : 'initialization' }
BlEvent >> initialize [
	super initialize.
	
	consumed := false.
	canBePropagated := true
]

{ #category : 'testing' }
BlEvent >> isBaseDrag [
	^ false
]

{ #category : 'testing' }
BlEvent >> isBaseFocus [
	^ false
]

{ #category : 'testing' }
BlEvent >> isBlur [
	^ false
]

{ #category : 'testing' }
BlEvent >> isClick [
	^ false
]

{ #category : 'testing' }
BlEvent >> isConsumed [
	<return: #Boolean>

	^ consumed
]

{ #category : 'testing' }
BlEvent >> isDoubleClick [
	^ false
]

{ #category : 'testing' }
BlEvent >> isDrag [
	^ false
]

{ #category : 'testing' }
BlEvent >> isElementEvent [
	^ false
]

{ #category : 'testing' }
BlEvent >> isFocus [
	^ false
]

{ #category : 'testing' }
BlEvent >> isFocusIn [
	^ false
]

{ #category : 'testing' }
BlEvent >> isFocusOut [
	^ false
]

{ #category : 'testing' }
BlEvent >> isFocusTransfer [
	^ false
]

{ #category : 'testing' }
BlEvent >> isGesture [
	^ false
]

{ #category : 'testing' }
BlEvent >> isKeyboard [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouse [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouseDown [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouseEnter [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouseLeave [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouseMove [
	^ false
]

{ #category : 'testing' }
BlEvent >> isMouseUp [
	^ false
]

{ #category : 'testing' }
BlEvent >> isSpaceEvent [
	^ false
]

{ #category : 'testing' }
BlEvent >> isTextInput [
	^ false
]

{ #category : 'testing' }
BlEvent >> isTouch [
	^ false
]

{ #category : 'testing' }
BlEvent >> isUIEvent [
	^ false
]

{ #category : 'testing' }
BlEvent >> isUniverseEvent [
	^ false
]

{ #category : 'firing' }
BlEvent >> newCopyFor: aTarget [
	^ self class new
		copyFrom: self;
		target: aTarget;
		yourself
]

{ #category : 'copying' }
BlEvent >> postCopy [
	super postCopy
]

{ #category : 'sending' }
BlEvent >> sendTo: anObject [
	
]

{ #category : 'accessing' }
BlEvent >> source [
	"Return an event target that plays a role of a source of this event"

	self
		assert: [ self hasSource ]
		description: [ 'Can not access a source if there is no one' ].

	^ source
]

{ #category : 'accessing' }
BlEvent >> source: aBlEventTarget [	
	source := aBlEventTarget
]

{ #category : 'api - accessing' }
BlEvent >> target [
	"Return a reference to the object that dispatched the event.
	It is different from #currentTarget when the event handler is called during the bubbling or capturing phase of the event."
	<return: #TBlEventTarget>

	^ target
]

{ #category : 'private - accessing' }
BlEvent >> target: aTBlEventTarget [
	target := aTBlEventTarget
]

{ #category : 'api - accessing' }
BlEvent >> timestamp [
	"Returns the time at which the event was created."
	<return: #DateAndTime>

	^ timestamp
]

{ #category : 'private - accessing' }
BlEvent >> timestamp: aDateAndTime [
	
	timestamp := aDateAndTime
]
