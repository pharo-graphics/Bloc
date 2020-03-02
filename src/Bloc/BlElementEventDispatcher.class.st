"
I am a special event dispatcher designed for high frequency events such as position in space changed or added to scene graph events
"
Class {
	#name : #BlElementEventDispatcher,
	#superclass : #BlBubblingEventDispatcher,
	#instVars : [
		'activatedElementEvents',
		'activatedGeneralEvents'
	],
	#category : #'Bloc-Events-Element'
}

{ #category : #adding }
BlElementEventDispatcher >> addEventHandler: aHandler [
	"It is not very common to have event handlers so we initialize registry lazily"

	handlers ifNil: [
		handlers := self defaultHandlerRegistry ].
	handlers add: aHandler.

	aHandler enableEventsIn: self.

	"send hook AFTER handler is added"
	aHandler onInstalledIn: self owner
]

{ #category : #'api - enable / disable' }
BlElementEventDispatcher >> disableEventType: anEventClass [
	anEventClass disableIn: self
]

{ #category : #'api - general events' }
BlElementEventDispatcher >> disableGeneralEventType: anEventClass [
	activatedGeneralEvents remove: anEventClass ifAbsent: [  ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchAddedToParent [
	activatedElementEvents hasAddedToParent
		ifTrue: [ self dispatchEvent: (BlElementAddedToParentEvent new) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchAddedToSceneGraph [
	activatedElementEvents hasAddedToSceneGraph
		ifTrue: [ self dispatchEvent: (BlElementAddedToSceneGraphEvent target: self owner) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchAddedToSuperParent: anElement [
	activatedElementEvents hasAddedToSuperParent
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementAddedToSuperParentEvent new addedElement: anElement) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchBackgroundChanged [
	activatedElementEvents hasBackgroundChanged
		ifTrue: [ self dispatchEvent: (BlElementBackgroundChangedEvent new) ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchBorderChanged [
	activatedElementEvents hasBorderChanged
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementBorderChangedEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchExtentChanged [
	activatedElementEvents hasExtentChanged
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementExtentChangedEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchLayoutChanged [
	activatedElementEvents hasLayoutChanged
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementLayoutChangedEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchPositionChanged [
	activatedElementEvents hasPositionChanged
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementPositionChangedEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchPositionInSpaceChanged [
	activatedElementEvents hasPositionInSpaceChanged
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementPositionInSpaceChangedEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchRemovedFromParent [
	activatedElementEvents hasRemovedFromParent
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementRemovedFromParentEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchRemovedFromSceneGraph [
	activatedElementEvents hasRemovedFromSceneGraph
		ifTrue: [ self ownerDo: [ :anEventTarget | anEventTarget dispatchEvent: (BlElementRemovedFromSceneGraphEvent new) ] ]
]

{ #category : #'api - event managing' }
BlElementEventDispatcher >> dispatchScrolled: aDelta [
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
	activatedGeneralEvents add: anEventClass
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enableLayoutChanged [
	activatedElementEvents addLayoutChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enablePositionChanged [
	activatedElementEvents addPositionChanged
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> enablePositionInSpaceChanged [
	activatedElementEvents addPositionChanged
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

{ #category : #'gt-extension' }
BlElementEventDispatcher >> gtEventsFor: aView [
	<gtView>
	
	^ aView columnedList
		priority: 2;
		title: 'Events';
		items: [ (activatedElementEvents asDictionary associations sorted: [ :a :b | a key < b key ]), (activatedGeneralEvents asArray collect: [ :each | each -> true ]) ];
		column: 'Type' 
			evaluated: [:each | each key ];
		column: 'Enabled' 
			evaluated: [:each | each value ]
]

{ #category : #initialization }
BlElementEventDispatcher >> initialize [
	super initialize.

	activatedElementEvents := BlElementEventDispatcherActivatedEvents new.
	activatedGeneralEvents := Set new
]

{ #category : #accessing }
BlElementEventDispatcher >> ownerDo: aBlock [
	owner ifNotNil: aBlock
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
	^ activatedGeneralEvents includes: anEventClass
]

{ #category : #'api - element events' }
BlElementEventDispatcher >> wantsLayoutChanged [
	^ activatedElementEvents hasLayoutChanged
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
