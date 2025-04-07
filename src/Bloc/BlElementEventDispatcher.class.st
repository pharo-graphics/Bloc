"
I am a special event dispatcher designed for high frequency events such as ""position in space changed"" or ""added to scene graph"" events

"
Class {
	#name : #BlElementEventDispatcher,
	#superclass : #BlBubblingEventDispatcher,
	#instVars : [
		'activatedElementEvents',
		'activatedGeneralEvents'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #adding }
BlElementEventDispatcher >> addEventHandler: aHandler [
	"It is not very common to have event handlers so we initialize registry lazily"

	handlers ifNil: [ handlers := self newHandlerRegistry ].
	handlers add: aHandler.

	aHandler enableEventsIn: self.

	"send hook AFTER handler is added"
	aHandler onInstalledIn: self owner
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableAddedToParent [
	activatedElementEvents clearAddedToParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableAddedToSceneGraph [
	activatedElementEvents clearAddedToSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableAddedToSuperParent [
	activatedElementEvents clearAddedToSuperParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableBackgroundChanged [
	activatedElementEvents clearBackgroundChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableBorderChanged [
	activatedElementEvents clearBorderChanged
]

{ #category : #'api - enable / disable' }
BlElementEventDispatcher >> disableEventType: anEventClass [
	anEventClass disableIn: self
]

{ #category : #'api - enable / disable' }
BlElementEventDispatcher >> disableEventType: anEventClass while: aBlock [

	self disableEventType: anEventClass.
	aBlock ensure: [ 
		self enableEventType: anEventClass ]

]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableExtentChanged [
	activatedElementEvents clearExtentChanged
]

{ #category : #'api - general events' }
BlElementEventDispatcher >> disableGeneralEventType: anEventClass [

	activatedGeneralEvents ifNil: [ ^ self ].
	activatedGeneralEvents remove: anEventClass ifAbsent: [  ].
	activatedGeneralEvents ifEmpty: [ activatedGeneralEvents := nil ]
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableLayoutChanged [
	activatedElementEvents clearLayoutChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableLayoutComputed [
	activatedElementEvents clearLayoutComputed
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableMousePickedOutside [
	activatedElementEvents clearMousePickedOutside
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disablePositionChanged [
	activatedElementEvents clearPositionChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disablePositionInSpaceChanged [
	activatedElementEvents clearPositionInSpaceChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableRemovedFromParent [
	activatedElementEvents clearRemovedFromParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableRemovedFromSceneGraph [
	activatedElementEvents clearRemovedFromSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableScrolledEvent [
	activatedElementEvents clearScrolledEvent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableSelectionAcquired [
	activatedElementEvents clearSelectionAcquired
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableSelectionLost [
	activatedElementEvents clearSelectionLost
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableTransformationChanged [
	activatedElementEvents clearTransformationChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> disableTransformationInSpaceChanged [
	activatedElementEvents clearTransformationInSpaceChanged
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchAddedToParent [
	activatedElementEvents hasAddedToParent
		ifTrue: [ self dispatchEvent: (BlElementAddedToParentEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchAddedToSceneGraph [
	activatedElementEvents hasAddedToSceneGraph
		ifTrue: [ self dispatchEvent: (BlElementAddedToSceneGraphEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchBackgroundChanged [
	activatedElementEvents hasBackgroundChanged
		ifTrue: [ self dispatchEvent: (BlElementBackgroundChangedEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchBorderChanged [
	activatedElementEvents hasBorderChanged
		ifTrue: [ self dispatchEvent: (BlElementBorderChangedEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchExtentChanged [
	activatedElementEvents hasExtentChanged
		ifTrue: [ self dispatchEvent: (BlElementExtentChangedEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchLayoutChanged [
	activatedElementEvents hasLayoutChanged
		ifTrue: [ self dispatchEvent: (BlElementLayoutChangedEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchLayoutComputed [
	activatedElementEvents hasLayoutComputed
		ifTrue: [ self dispatchEvent: (BlElementLayoutComputedEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchPositionChanged [
	activatedElementEvents hasPositionChanged
		ifTrue: [ self dispatchEvent: (BlElementPositionChangedEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchPositionInSpaceChanged [
	activatedElementEvents hasPositionInSpaceChanged
		ifTrue: [ self dispatchEvent: (BlElementPositionInSpaceChangedEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchRemovedFromParent [
	activatedElementEvents hasRemovedFromParent
		ifTrue: [ self dispatchEvent: (BlElementRemovedFromParentEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchRemovedFromSceneGraph [
	activatedElementEvents hasRemovedFromSceneGraph
		ifTrue: [ self dispatchEvent: (BlElementRemovedFromSceneGraphEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchScrolled: aDelta [
	activatedElementEvents hasScrolledEvent
		ifTrue: [ self dispatchEvent: ((BlElementScrolledEvent from: self) delta: aDelta) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchSelectionAcquired: theBounds [

	^ activatedElementEvents hasSelectionAcquired
		ifFalse: [ false ]
		ifTrue: [
			| anEvent |
			anEvent := (BlElementSelectionAcquiredEvent from: self) bounds: theBounds.
			self dispatchEvent: anEvent.
			anEvent isConsumed ]

]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchSelectionLost [
	activatedElementEvents hasSelectionLost
		ifTrue: [ self dispatchEvent: (BlElementSelectionLostEvent from: self) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchTransformationChanged [
	activatedElementEvents hasTransformationChanged
		ifTrue: [ self dispatchEvent: (BlElementTransformationChangedEvent from: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchTransformationInSpaceChanged [
	activatedElementEvents hasTransformationInSpaceChanged
		ifTrue: [ self dispatchEvent: (BlElementTransformationInSpaceChangedEvent from: self owner) ]
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableAddedToParent [
	activatedElementEvents addAddedToParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableAddedToSceneGraph [
	activatedElementEvents addAddedToSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableAddedToSuperParent [
	activatedElementEvents addAddedToSuperParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableBackgroundChanged [
	activatedElementEvents addBackgroundChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableBorderChanged [
	activatedElementEvents addBorderChanged
]

{ #category : #'api - enable / disable' }
BlElementEventDispatcher >> enableEventType: anEventClass [
	anEventClass enableIn: self
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableExtentChanged [
	activatedElementEvents addExtentChanged
]

{ #category : #'api - general events' }
BlElementEventDispatcher >> enableGeneralEventType: anEventClass [

	activatedGeneralEvents ifNil: [
		activatedGeneralEvents := self newActivatedGeneralEvents ].
	activatedGeneralEvents add: anEventClass
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableLayoutChanged [
	activatedElementEvents addLayoutChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableLayoutComputed [
	activatedElementEvents addLayoutComputed
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableMousePickedOutside [
	activatedElementEvents addMousePickedOutside
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enablePositionChanged [
	activatedElementEvents addPositionChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enablePositionInSpaceChanged [
	activatedElementEvents addPositionInSpaceChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableRemovedFromParent [
	activatedElementEvents addRemovedFromParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableRemovedFromSceneGraph [
	activatedElementEvents addRemovedFromSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableScrolledEvent [
	activatedElementEvents addScrolledEvent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableSelectionAcquired [
	activatedElementEvents addSelectionAcquired
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableSelectionLost [
	activatedElementEvents addSelectionLost
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableTransformationChanged [
	activatedElementEvents addTransformationChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableTransformationInSpaceChanged [
	activatedElementEvents addTransformationInSpaceChanged
]

{ #category : #initialization }
BlElementEventDispatcher >> initialize [

	super initialize.

	activatedElementEvents := BlElementEventDispatcherActivatedEvents new.
	
	"IdentitySet on 64bit systems occupies in total 72 bytes, which is quite a lot.
	Since we do not provide accessors it is fine to initialize it lazily"
	activatedGeneralEvents := nil
]

{ #category : #initialization }
BlElementEventDispatcher >> newActivatedGeneralEvents [
	^ IdentitySet new
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsAddedToParent [
	^ activatedElementEvents hasAddedToParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsAddedToSceneGraph [
	^ activatedElementEvents hasAddedToSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsAddedToSuperParent [
	^ activatedElementEvents hasAddedToSuperParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsBackgroundChanged [
	^ activatedElementEvents hasBackgroundChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsBorderChanged [
	^ activatedElementEvents hasBorderChanged
]

{ #category : #'api - enable / disable' }
BlElementEventDispatcher >> wantsEventType: anEventClass [
	^ anEventClass wantedIn: self
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsExtentChanged [
	^ activatedElementEvents hasExtentChanged
]

{ #category : #'api - general events' }
BlElementEventDispatcher >> wantsGeneralEventType: anEventClass [
	^ activatedGeneralEvents
		ifNil: [ false ]
		ifNotNil: [ :theActivatedEvents | theActivatedEvents includes: anEventClass ]
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsLayoutChanged [
	^ activatedElementEvents hasLayoutChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsLayoutComputed [
	^ activatedElementEvents hasLayoutComputed
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsMousePickedOutside [
	^ activatedElementEvents hasMousePickedOutside
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsPositionChanged [
	^ activatedElementEvents hasPositionChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsPositionInSpaceChanged [
	^ activatedElementEvents hasPositionInSpaceChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsRemovedFromParent [
	^ activatedElementEvents hasRemovedFromParent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsRemovedFromSceneGraph [
	^ activatedElementEvents hasRemovedFromSceneGraph
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsScrolledEvent [
	^ activatedElementEvents hasScrolledEvent
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsSelectionAcquired [
	^ activatedElementEvents hasSelectionAcquired
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsSelectionLost [
	^ activatedElementEvents hasSelectionLost
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsTransformationChanged [
	^ activatedElementEvents hasTransformationChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsTransformationInSpaceChanged [
	^ activatedElementEvents hasTransformationInSpaceChanged
]
