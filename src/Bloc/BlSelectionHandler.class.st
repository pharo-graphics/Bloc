"
I am a helper class intended to help developer implement drag-based selection.

May be used to implement text selection or desktop like selection behaviour

"
Class {
	#name : #BlSelectionHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'origin',
		'corner',
		'area',
		'container',
		'selected'
	],
	#category : #'Bloc-Utilities - Selection'
}

{ #category : #geometry }
BlSelectionHandler >> computeSelectionArea [
	area origin: (origin min: corner) corner: (corner max: origin)
]

{ #category : #'dnd handlers' }
BlSelectionHandler >> dragEndEvent: anEvent [	

	anEvent consume.
		
	origin := nil.
	corner := nil.
	area left: 0 top: 0 right: 0 bottom: 0
]

{ #category : #'dnd handlers' }
BlSelectionHandler >> dragEvent: anEvent [	
	"For selection we want to handle only those drag events that began exactly
	on the element I attached to"
		
	self hasOrigin
		ifFalse: [ ^ self ].
	
	anEvent consume.
	
	corner := anEvent position.	
	self computeSelectionArea.
		
	self selectionChanged
]

{ #category : #'dnd handlers' }
BlSelectionHandler >> dragStartEvent: anEvent [

	anEvent consume.
	origin := anEvent position
]

{ #category : #accessing }
BlSelectionHandler >> eventsToHandle [
	^ {
		BlDragEvent.
		BlDragStartEvent.
		BlDragEndEvent
	}
]

{ #category : #'selection - handling' }
BlSelectionHandler >> handleDeselected: anElement [
	anElement eventDispatcher dispatchSelectionLost
]

{ #category : #'selection - handling' }
BlSelectionHandler >> handleSelected: anElement in: anIntersection [
	"we should make sure that we don't destroy existing BlBounds by performing destructive operation"
	self
		assert: [ anIntersection ~~ self selectionArea  ]
		description: [ 'Intersection must be a different bounds object than selection area' ].

	^ anElement eventDispatcher dispatchSelectionAcquired: anIntersection encompass
]

{ #category : #testing }
BlSelectionHandler >> hasOrigin [
	"Return true if I know selection origin position, false otherwise"
	<return: #Boolean>

	^ origin isNotNil
]

{ #category : #initialization }
BlSelectionHandler >> initialize [
	super initialize.
	
	area := BlBounds new.
	selected := IdentityDictionary new
]

{ #category : #selection }
BlSelectionHandler >> intersect: aChildElement in: aSelectionBounds ifNone: aNoneBlock [
	"Return selection intersection bounds of a given element and provided
	selection bounds in local child coordinates if intersection exists
	or evaluate a none block otherwise.
	Note: you should override me to modify selection area detection, for example
	for the case of text selection intersection is not just plain intersection"
	<return: #BlBounds>

	^ aSelectionBounds
		intersect: aChildElement boundsInLocal
		ifNone: aNoneBlock
]

{ #category : #installation }
BlSelectionHandler >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	
	container := anElement
]

{ #category : #selection }
BlSelectionHandler >> selectedChildren: anElement in: aBlBounds do: aBlock [
	"Evaluate a block with all children of an element that intersect with provided bounds.
	aBlBounds is given in local coordinates of anElement"	

	((self shouldSelect: anElement in: aBlBounds)
		and: [ (aBlock value: anElement value: aBlBounds) not ])
			ifFalse: [ ^ self ].
		
	anElement childrenDo: [ :aChild |	
		| boundsInLocal |
		boundsInLocal := aChild parentBoundsToLocal: aBlBounds copy.
		self
			selectedChildren: aChild
			in: boundsInLocal
			do: aBlock ]
]

{ #category : #geometry }
BlSelectionHandler >> selectionArea [
	"Return bounds representing a selection area in global coordinates"
	<return: #BlBounds>
	self
		assert: [ origin isNotNil and: [ corner isNotNil ] ]
		description: [ 'Selection origin and corner must be known' ].

	^ area
]

{ #category : #'selection - handling' }
BlSelectionHandler >> selectionChanged [
	"Is sent when #selectionArea changed"
	| oldSelected |

	oldSelected := selected copy.
	selected removeAll.

	self
		selectedChildren: container
		in: (container globalBoundsToLocal: self selectionArea copy)
		do: [ :anElement :aSelectionInLocal |
			| anIntersectionInLocal isSelectionChanged |

			anIntersectionInLocal := self
				intersect: anElement
				in: aSelectionInLocal
				ifNone: [ self error: 'Selected child must intersect with selection' ].
			
			oldSelected
				at: anElement
				ifPresent: [ :anExistingIntersection | isSelectionChanged := anExistingIntersection ~= anIntersectionInLocal ]
				ifAbsent: [ isSelectionChanged := true ].
	
			selected
				at: anElement
				put: anIntersectionInLocal.

			oldSelected removeKey: anElement ifAbsent: [].

			"return true / false if selection event was consumed (handled)"
			isSelectionChanged
				ifTrue: [ self handleSelected: anElement in: anIntersectionInLocal ]
				ifFalse: [ false ] ].
	
	oldSelected keysDo: [ :anElement | self handleDeselected: anElement ]
]

{ #category : #selection }
BlSelectionHandler >> shouldSelect: aChildElement in: aSelectionBounds [
	"Return true if a child element should be selected taking into account
	provided selection area bounds given in local coordinates of a child element"
	<return: #Boolean>
	
	^ (self
		intersect: aChildElement
		in: aSelectionBounds
		ifNone: [ nil ]) isNotNil
]
