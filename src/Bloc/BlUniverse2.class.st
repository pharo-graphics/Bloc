Class {
	#name : #BlUniverse2,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'spaces',
		'deferredActions',
		'eventDispatcher',
		'hostClass'
	],
	#classVars : [
		'Universes'
	],
	#category : #'Bloc-Universe 2'
}

{ #category : #'instance creation' }
BlUniverse2 class >> forHost: aHostClass [
	^ Universes
		detect: [ :eachUniverse | eachUniverse hostClass = aHostClass ]
		ifFound: #yourself
		ifNone: [
			| aUniverse |
			aUniverse := self new hostClass: aHostClass.
			Universes := Universes copyWith: aUniverse.
			aUniverse ]
]

{ #category : #'instance creation' }
BlUniverse2 class >> glutin [
	<blocHost>

	^ self forHost: BlGlutinHost
]

{ #category : #'class initialization' }
BlUniverse2 class >> initialize [
	Universes := #()
]

{ #category : #'instance creation' }
BlUniverse2 class >> morphic [
	<blocHost>

	^ self forHost: BlMorphicHost
]

{ #category : #'api - spaces' }
BlUniverse2 >> closeSpace: aSpace [
	"It should be possible to close a space from the other thread"
]

{ #category : #initialization }
BlUniverse2 >> defaultEventDispatcher [
	^ BlDirectEventDispatcher on: self
]

{ #category : #initialization }
BlUniverse2 >> defaultEventListener [
	^ BlUniverseEventListener new
]

{ #category : #'deferred message' }
BlUniverse2 >> defer: aValuable [
	"#defer: can be used from any thread to execute a valuable in the GUI thread
	You can use it to update the GUI states from any other thread.
	The valuable will be evaluated as soon as possible."

	deferredActions nextPut: aValuable
]

{ #category : #'event management accessing' }
BlUniverse2 >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'api - spaces' }
BlUniverse2 >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"
	<return: #Boolean>

	^ self spaces isNotEmpty
]

{ #category : #accessing }
BlUniverse2 >> hostClass [
	^ hostClass
]

{ #category : #accessing }
BlUniverse2 >> hostClass: aHostClass [
	hostClass := aHostClass
]

{ #category : #initialization }
BlUniverse2 >> initialize [
	super initialize.

	spaces := #().
	hostClass := BlHeadlessHost.
	deferredActions := WaitfreeQueue new.

	eventDispatcher := self defaultEventDispatcher.
	self addEventHandler: self defaultEventListener
]

{ #category : #'api - spaces' }
BlUniverse2 >> openSpace: aSpace [
	"It should be possible to add a space from the other thread"

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host space!' ].

	self
		assert: [ aSpace host isNotNil ]
		description: [ 'Space must have a host' ].

	"First of all we need to add space to the space manager"
	spaces := spaces copyWith: aSpace.

	"then create and show it in a host space"
	aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show.

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].

	"Note: we should send shown event after everything else is done, because
	theoretically, that only space could be closed as a reaction to the event"
	aSpace dispatchEvent: (BlSpaceShownEvent new space: self).
	
	"Notify root element that it is now visible to the user"
	aSpace root space: aSpace.
	aSpace root dispatchAddedToSceneGraph.
	
	aSpace host isRunning
		ifFalse: [ aSpace host start ]
]

{ #category : #'api - spaces' }
BlUniverse2 >> spaces [
	<return: #Collection of: #BlSpace>

	^ spaces
]
