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
		'consumed'
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

{ #category : #'api - enable / disable' }
BlEvent class >> wantedIn: anEventDispatcher [
	^ anEventDispatcher wantsGeneralEventType: self
]

{ #category : #'private - steps' }
BlEvent >> arrivedTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget
]

{ #category : #'private - steps' }
BlEvent >> bubblingTarget: aTBlEventTarget [
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].

	currentTarget := aTBlEventTarget
]

{ #category : #testing }
BlEvent >> canBePropagated [
	<return: #Boolean>

	^ canBePropagated
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

	currentTarget := aTBlEventTarget
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

	currentTarget := aTBlEventTarget
]

{ #category : #'as yet unclassified' }
BlEvent >> gtInspectorCurrentTargetIn: composite [
	<gtInspectorPresentationOrder: 15>
	
	(self currentTarget isKindOf: BlElement)
		ifTrue: [ (self currentTarget gtInspectorPreviewIn: composite) title: 'Current target' ]
]

{ #category : #'as yet unclassified' }
BlEvent >> gtInspectorTargetIn: composite [
	<gtInspectorPresentationOrder: 15>
	
	(self target isKindOf: BlElement)
		ifTrue: [ (self target gtInspectorPreviewIn: composite) title: 'Target' ]
]

{ #category : #'as yet unclassified' }
BlEvent >> gtInspectorTraversedTargetsIn: aComposite [
	<gtInspectorPresentationOrder: 10>

	^ aComposite table
		title: 'Traversed';
		display: [ self traversedTargets ];
		icon: [ :each | each target asSpartaForm scaledToSize: 16@16 ];
		column: 'Phase'
			evaluated: [ :each | each type ]
			width: 100;
		column: 'Target'
			evaluated: [ :each | each target ];
		column: 'Dispatcher'
			evaluated: [ :each | each dispatcher ]
]

{ #category : #'as yet unclassified' }
BlEvent >> gtInspectorTraversedTargetsOnTreeIn: composite [
	<gtInspectorPresentationOrder: 15>
	composite blocMondrian
		title: 'Tree';
		painting: [ :view | self traversedTargetsTreeWith: view ]
]

{ #category : #testing }
BlEvent >> hasSource [
	<return: #Boolean>
	
	^ source isNotNil
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
	super postCopy
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
	^ #()
]

{ #category : #'as yet unclassified' }
BlEvent >> traversedTargetsTreeWith: mondrian [
	| thePairs connectedTargets topMostTarget aCurrentTarget |
	
	self traversedTargets
		ifEmpty: [ ^ self ].
	
	thePairs := Array streamContents: [ :aStream | 
		self traversedTargets overlappingPairsDo: [ :from :to | aStream nextPut: from -> to ] ].

	aCurrentTarget := self traversedTargets first target.
	topMostTarget := (aCurrentTarget hasOwner)
		ifTrue: [ aCurrentTarget owner topMostParent ]
		ifFalse: [ aCurrentTarget ].
	connectedTargets := (topMostTarget isKindOf: BlElement)
		ifFalse: [ { topMostTarget } ] 
		ifTrue: [					
			| allNodes |
			allNodes := OrderedCollection with: topMostTarget.
			topMostTarget eventDispatcher handlersDo: [ :aHandler |
					aHandler hasOwner ifTrue: [ allNodes add: aHandler ] ].
			topMostTarget allChildrenBreadthFirstDo: [ :eachElement |
				allNodes add: eachElement.
				eachElement eventDispatcher handlersDo: [ :aHandler |
					aHandler hasOwner ifTrue: [ allNodes add: aHandler ] ] ].
			allNodes ]. 

	mondrian nodes
		shape: [ :aTarget |
			| text |
			text := aTarget gtDisplayString asRopedText.
			text foreground: Color lightGray.
			BlTextElement new
				text: text;
				padding: (BlInsets all: 5) ];
		with: (connectedTargets).
	mondrian edges
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connect: (connectedTargets select: [ :each | each hasOwner ])
			from: [ :aTarget | aTarget owner ].

	mondrian edges
		shape: [ :x |
			| color |
			color := Color red.
			(x value isKindOf: BlEventTraversalBubblingStep) ifTrue: [ color := Color blue ].
			(x value isKindOf: BlEventTraversalTargetStep) ifTrue: [ color := Color green ].
			(x value isKindOf: BlEventTraversalForwardingStep) ifTrue: [ color := Color gray ].
			BlParabollaArcElement new 
				border: (BlBorder paint: (color alpha: 0.4) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (color alpha: 0.4); width: 2; build)) ];
		passive;
		connect: thePairs from: [ :x | x key target ]
		to: [ :x | x value target ].
	mondrian layout horizontalTree nodeDistance: 40
]
