Class {
	#name : #BlDragLetter,
	#superclass : #BlElement,
	#instVars : [
		'character',
		'defaultContainer'
	],
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #accessing }
BlDragLetter >> character [ 

	^ character 
]

{ #category : #accessing }
BlDragLetter >> character: aCharacter [

	character := aCharacter.
	
	self addChild: (BlTextElement new
				   labelMeasurement;
				   text: aCharacter asString asRopedText)
]

{ #category : #accessing }
BlDragLetter >> defaultContainer [ 

	^ defaultContainer 
]

{ #category : #accessing }
BlDragLetter >> defaultContainer: aBlElement [ 

	defaultContainer := aBlElement 
]

{ #category : #initialization }
BlDragLetter >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal alignCenter;
		  size: 30 @ 30;
		  margin: (BlInsets all: 5);
		  background: Color veryVeryLightGray;
		  border: (BlBorder paint: Color veryLightGray width: 1);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		  effect: (BlGaussianShadowEffect
				   color: (Color lightGray alpha: 0.4)
				   width: 2
				   offset: 0 @ 0).
	self initializeEvents 
]

{ #category : #initialization }
BlDragLetter >> initializeEvents [

	| space |
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		'source1 BlStartDragEvent' traceCr.
		'is vowel ? ' trace.
		self isVowel traceCr.
		space := self space.
		self removeFromParent.
		space root addChild: self.
		self preventMeAndChildrenMouseEvents ].

	self addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consumed: true.
		'source1 BlDragEndEvent' traceCr.
		self background: Color veryVeryLightGray.
		"self removeFromParent.
		defaultContainer addChild: self."
		self allowMeAndChildrenMouseEvents ].

	self addEventHandlerOn: BlDragEvent do: [ :event |
		event consumed: true. "self inform:  'source1 BlDragEvent'."
		self position: event position ].

	^ self
]

{ #category : #testing }
BlDragLetter >> isVowel [ 

	^ character isVowel 
]
