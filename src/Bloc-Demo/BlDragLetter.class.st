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

	| space offset |
	self addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		space := self space.
		offset := self positionInSpace - event position.
		self removeFromParent.
		space root addChild: self.
		self preventMeAndChildrenMouseEvents ].

	self addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consumed: true.
		'dragEvent' traceCr.
		self background: Color veryVeryLightGray.
		self allowMeAndChildrenMouseEvents ].

	self addEventHandlerOn: BlDragEvent do: [ :event |
		event consumed: true.
		self position: event position + offset ].

	^ self
]

{ #category : #testing }
BlDragLetter >> isVowel [ 

	^ character isVowel 
]
