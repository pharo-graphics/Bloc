Class {
	#name : #BlDragLetterContainer,
	#superclass : #BlElement,
	#instVars : [
		'dropAcceptCondition'
	],
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptCondition [ 

	^ dropAcceptCondition 
]

{ #category : #accessing }
BlDragLetterContainer >> dropAcceptCondition: aBlockClosure [

	dropAcceptCondition := aBlockClosure 
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
	 self initializeDropEvent
]

{ #category : #initialization }
BlDragLetterContainer >> initializeDropEvent [

	self addEventHandlerOn: BlDropEvent do: [ :event |
		| element |
		event consume.
		element := event gestureSource.
		(self dropAcceptCondition value: element)
			ifTrue: [
				'accept' traceCr.
				element removeFromParent.
				self addChild: element ]
			ifFalse: [
				'reject' traceCr.
				element
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				element defaultContainer addChild: element ] ]
]
