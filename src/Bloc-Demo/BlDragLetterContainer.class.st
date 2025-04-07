Class {
	#name : #BlDragLetterContainer,
	#superclass : #BlElement,
	#instVars : [
		'dropAcceptBehavior',
		'dropRejectBehavior',
		'dragEnterAcceptBehavior',
		'dragEnterRejectBehavior',
		'dragLeaveBehavior',
		'dropAcceptCondition'
	],
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #accessing }
BlDragLetterContainer >> dragEnterAcceptBehavior [

	^ dragEnterAcceptBehavior
]

{ #category : #accessing }
BlDragLetterContainer >> dragEnterAcceptBehavior: aBlockClosure [

	dragEnterAcceptBehavior := aBlockClosure
]

{ #category : #accessing }
BlDragLetterContainer >> dragEnterRejectBehavior [

	^ dragEnterRejectBehavior
]

{ #category : #accessing }
BlDragLetterContainer >> dragEnterRejectBehavior: aBlockClosure [

	dragEnterRejectBehavior := aBlockClosure
]

{ #category : #accessing }
BlDragLetterContainer >> dragLeaveBehavior [

	^ dragLeaveBehavior
]

{ #category : #accessing }
BlDragLetterContainer >> dragLeaveBehavior: aBlockClosure [

	dragLeaveBehavior := aBlockClosure
]

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptBehavior [

	^ dropAcceptBehavior
]

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptBehavior: aBlockClosure [

	dropAcceptBehavior := aBlockClosure
]

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptCondition [ 

	^ dropAcceptCondition 
]

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptCondition: aBlockClosure [

	dropAcceptCondition := aBlockClosure 
]

{ #category : #accessing }
BlDragLetterContainer >> dropRejectBehavior [

	^ dropRejectBehavior
]

{ #category : #accessing }
BlDragLetterContainer >> dropRejectBehavior: aBlockClosure [

	dropRejectBehavior := aBlockClosure
]

{ #category : #initialization }
BlDragLetterContainer >> initialize [

	super initialize.
	self
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets all: 10);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5).

	self dropAcceptCondition: [ :a | true ].
	self initializeDropEvent.
	self initializeDragEnterEvent.
	self initializeDragLeaveEvent 
]

{ #category : #initialization }
BlDragLetterContainer >> initializeDragEnterEvent [

	self addEventHandlerOn: BlDragEnterEvent do: [ :event |
		| element |
		event consumed: true.
		element := event gestureSource.
		(self dropAcceptCondition value: element) ifTrue: [
			self dragEnterAcceptBehavior value: element ]
		ifFalse: [ self dragEnterRejectBehavior value: element ] ]
]

{ #category : #initialization }
BlDragLetterContainer >> initializeDragLeaveEvent [ 

	self addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		|element|
		event consume.
		element := event gestureSource.
		self dragLeaveBehavior value: element ].
]

{ #category : #initialization }
BlDragLetterContainer >> initializeDropEvent [

	self addEventHandlerOn: BlDropEvent do: [ :event |
		| element |
		event consume.
		'dropEvent' traceCr.
		element := event gestureSource.
		(self dropAcceptCondition value: element)
			ifTrue: [ "self dropAcceptBehaviour value: element"
				element removeFromParent.
				self addChild: element ]
			ifFalse: [ "self dropRejectBehaviour value: element"
				element
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				element defaultContainer addChild: element ] ]
]
