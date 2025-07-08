"
I am a RGB Text Element designed for a Color Picker.

I display different Text Elements referencing the numerical rgb values of the current color.

I also have a Text Element showing 'RGB' you can click on to copy the rgb triplet to the clipboard.
"
Class {
	#name : #BlRGBTextElement,
	#superclass : #BlElement,
	#instVars : [
		'rgbElt',
		'rElt',
		'gElt',
		'bElt',
		'owner'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #initialization }
BlRGBTextElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c margin: (BlInsets horizontal: 10 vertical: 5).
		c vertical fitContent.
		c horizontal fitContent ].
	self initializeTextElements
]

{ #category : #initialization }
BlRGBTextElement >> initializeTextElements [

	rgbElt := BlTextElement new
		          padding: (BlInsets all: 10);
		          margin: (BlInsets left: 0 right: 5);
		          text: 'RGB' asRopedText;
		          background: (Color
				           r: 0.94
				           g: 0.94
				           b: 0.94
				           alpha: 1.0);
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		          addEventHandlerOn: BlClickEvent do: [ :e |
			          e consume.
			          Clipboard clipboardText: owner color rgbTriplet asString.
			          self inform: 'RGB Triplet copied to clipboard' ];
		          yourself.

	self addChild: rgbElt.

	rElt := BlTextElement new
		        padding: (BlInsets all: 10);
		        margin: (BlInsets left: 5 right: 5);
		        text: '255' asRopedText;
		        background: (Color
				         r: 0.94
				         g: 0.94
				         b: 0.94
				         alpha: 1.0);
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		        extent: 20 @ 10.

	self addChild: rElt.

	gElt := BlTextElement new
		        padding: (BlInsets all: 10);
		        margin: (BlInsets left: 5 right: 5);
		        text: '0' asRopedText;
		        background: (Color
				         r: 0.94
				         g: 0.94
				         b: 0.94
				         alpha: 1.0);
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		        extent: 20 @ 10.

	self addChild: gElt.

	bElt := BlTextElement new
		        padding: (BlInsets all: 10);
		        margin: (BlInsets left: 5 right: 0);
		        text: '0' asRopedText;
		        background: (Color
				         r: 0.94
				         g: 0.94
				         b: 0.94
				         alpha: 1.0);
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		        extent: 20 @ 10.

	self addChild: bElt
]

{ #category : #'children accessing' }
BlRGBTextElement >> owner: anElement [

	owner := anElement 
	
]

{ #category : #'as yet unclassified' }
BlRGBTextElement >> updateRGBCode [ 

	| code |
	code := owner color rgbTriplet.
	rElt text: (code first * 255) floor asString asRopedText.
	gElt text: (code second * 255) floor asString asRopedText.
	bElt text: (code third * 255) floor asString asRopedText
]
