"
I am a Alpha Text Element designed for a Color Picker.

I display a Text Element referencing the alpha value of the current color as a percentage.
"
Class {
	#name : #BlAlphaTextElement,
	#superclass : #BlElement,
	#instVars : [
		'valueElt',
		'owner',
		'alphaElt'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #initialization }
BlAlphaTextElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c margin: (BlInsets
				 top: 5
				 right: 10
				 bottom: 5
				 left: 10).
		c vertical fitContent.
		c horizontal fitContent ].
	self initializeTextElements
]

{ #category : #initialization }
BlAlphaTextElement >> initializeTextElements [

	alphaElt := BlTextElement new
		            padding: (BlInsets all: 10);
		            margin: (BlInsets left: 0 right: 5);
		            text: 'ALPHA' asRopedText;
		            background: (Color
				             r: 0.94
				             g: 0.94
				             b: 0.94
				             alpha: 1.0);
		            geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		            addEventHandlerOn: BlClickEvent do: [ :e |
			            e consume.
			            Clipboard clipboardText: valueElt text asString ];
		            yourself.

	self addChild: alphaElt.

	valueElt := BlTextElement new
		            padding: (BlInsets all: 10);
		            margin: (BlInsets left: 5 right: 5);
		            text: '100%' asRopedText;
		            background: (Color
				             r: 0.94
				             g: 0.94
				             b: 0.94
				             alpha: 1.0);
		            geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		            size: 30 @ 10.

	self addChild: valueElt
]

{ #category : #accessing }
BlAlphaTextElement >> owner: anElement [ 

	owner := anElement 
]

{ #category : #updating }
BlAlphaTextElement >> updateAlphaCode [

	valueElt text: ((owner alpha * 100) rounded asString , '%') asRopedText
]
