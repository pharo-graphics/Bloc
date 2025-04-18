"
Bloc's root announcement class. I have many subclasses representing concrete event types:
```
BlEvent allSubclasses
```

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
		'timestampInMicroseconds'
	],
	#category : #'Bloc-Events'
}

{ #category : #'api - enable / disable' }
BlEvent class >> disableIn: anEventDispatcher [

	anEventDispatcher disableGeneralEventType: self
]

{ #category : #'api - enable / disable' }
BlEvent class >> enableIn: anEventDispatcher [

	anEventDispatcher enableGeneralEventType: self
]

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent [

	^ self fireEvent: anEvent target: anEvent target
]

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent from: aTopEventTarget [

	^ self fireEvent: anEvent from: aTopEventTarget to: anEvent target
]

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent from: aTopEventTarget to: aTargetEventTarget [

	| theEvent aDispatcherChain |
	theEvent := anEvent.

	anEvent hasSource ifFalse: [ anEvent source: aTargetEventTarget ].

	anEvent target = aTargetEventTarget ifFalse: [
		theEvent := anEvent newCopyFor: aTargetEventTarget ].

	aDispatcherChain :=
		aTargetEventTarget
			buildEventDispatchChain: BlEventDispatcherChain empty
			upTo: aTopEventTarget.

	^ aDispatcherChain dispatchEvent: theEvent
]

{ #category : #'event management' }
BlEvent class >> fireEvent: anEvent target: anEventTarget [

	| theEvent aDispatcherChain |
	theEvent := anEvent.

	anEvent hasSource ifFalse: [ anEvent source: anEventTarget ].

	anEvent target = anEventTarget ifFalse: [
		theEvent := anEvent newCopyFor: anEventTarget ].

	aDispatcherChain :=
		anEventTarget buildEventDispatchChain: BlEventDispatcherChain empty.

	^ aDispatcherChain dispatchEvent: theEvent
]

{ #category : #accessing }
BlEvent class >> from: anEventTarget [

	^ self new
		target: anEventTarget;
		source: anEventTarget;
		yourself
]

{ #category : #accessing }
BlEvent class >> target: anObject [

	^ self new
		target: anObject;
		yourself
]

{ #category : #private }
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

{ #category : #'api - enable / disable' }
BlEvent class >> wantedIn: anEventDispatcher [

	^ anEventDispatcher wantsGeneralEventType: self
]

{ #category : #'private - steps' }
BlEvent >> arrivedTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : #converting }
BlEvent >> asDictionaryForExport [
	^ OrderedDictionary new 
		at: #event put: self class name;
		at: #source put: (source ifNotNil: [ :aSource | self class targetToDictionaryForExport: aSource ]);
		at: #target put: (target ifNotNil: [ :aTarget | self class targetToDictionaryForExport: aTarget ]);
		at: #currentTarget put: (currentTarget ifNotNil: [ :aCurrentTarget | self class targetToDictionaryForExport: aCurrentTarget ]);
		at: #timestamp put: self timestamp asString;
		at: #canBePropagated put: canBePropagated;
		at: #consumed put: consumed;
		yourself
]

{ #category : #'private - steps' }
BlEvent >> bubblingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : #testing }
BlEvent >> canBePropagated [

	^ canBePropagated
]

{ #category : #'private - accessing' }
BlEvent >> canBePropagated: aBoolean [

	canBePropagated := aBoolean
]

{ #category : #'private - steps' }
BlEvent >> capturingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : #testing }
BlEvent >> consume [

	consumed := true
]

{ #category : #testing }
BlEvent >> consumed: aBoolean [

	consumed := aBoolean
]

{ #category : #copying }
BlEvent >> copyFrom: anEvent [
	super copyFrom: anEvent.

	"new copies are not yet consumed"
	consumed := false
]

{ #category : #copying }
BlEvent >> copySharedStatesFrom: anEvent [

	" Update the receiver state from copied event after the copied event has been dispatched "
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

{ #category : #'api - timestamp' }
BlEvent >> fillFromTime: aBlTime [

	aBlTime ifNil: [ ^ self ]. "See: https://github.com/pharo-graphics/Bloc/issues/733"
	timestampInMicroseconds := aBlTime nowInUTCMicroseconds.
	timestamp := nil
]

{ #category : #firing }
BlEvent >> fire [
	BlEvent fireEvent: self
]

{ #category : #'private - steps' }
BlEvent >> forwardingTarget: aTBlEventTarget [

	currentTarget := aTBlEventTarget
]

{ #category : #testing }
BlEvent >> hasSource [
	
	^ source isNotNil
]

{ #category : #'api - timestamp' }
BlEvent >> hasTimestamp [
	"Returns the `DateAndTime` at which the event was created."

	^ timestampInMicroseconds isNotNil
]

{ #category : #initialization }
BlEvent >> initialize [

	super initialize.

	consumed := false.
	canBePropagated := true
]

{ #category : #testing }
BlEvent >> isBaseDrag [
	^ false
]

{ #category : #testing }
BlEvent >> isBaseFocus [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/704'.

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
	<return: #Boolean>

	^ consumed
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
BlEvent >> isElementEvent [
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
BlEvent >> isUIEvent [
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

{ #category : #printing }
BlEvent >> printExtraDetailsOn: aStream [

	aStream print: self timestamp.
	aStream
		nextPutAll: ' target: ';
		print: target.
	self hasSource ifTrue: [
		aStream
			nextPutAll: ' source: ';
			print: source ]
]

{ #category : #printing }
BlEvent >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(.
	self printExtraDetailsOn: aStream.
	aStream nextPut: $)
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

{ #category : #'api - timestamp' }
BlEvent >> timestamp [
	"Returns the `DateAndTime` at which the event was created."

	^ timestamp ifNil: [
		timestampInMicroseconds ifNotNil: [
			timestamp := DateAndTime fromUTCMicrosecondClockValue: timestampInMicroseconds ] ]
]

{ #category : #'api - timestamp' }
BlEvent >> timestamp: aDateAndTime [

	self deprecated: 'Should use fillFromTime:'.

	timestampInMicroseconds := aDateAndTime utcMicroSeconds.
	timestamp := nil
]
