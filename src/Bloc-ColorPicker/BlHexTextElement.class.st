"
I am a Hex Text Element designed for a Color Picker.

I display a Text Element referencing the Hex code of the current color.

I also have a Text Element showing 'HEX' you can click on to copy the Hex code to the clipboard.
"
Class {
	#name : #BlHexTextElement,
	#superclass : #BlElement,
	#instVars : [
		'hexElt',
		'valueElt',
		'owner'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #initialization }
BlHexTextElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c margin: (BlInsets horizontal: 10 vertical: 5).
		c horizontal fitContent.
		c vertical fitContent ].
	self initializeTextElements
]

{ #category : #initialization }
BlHexTextElement >> initializeTextElements [

	hexElt := BlTextElement new
		          padding: (BlInsets all: 10);
		          margin: (BlInsets left: 0 right: 5);
		          text: 'HEX' asRopedText;
		          background: (Color
				           r: 0.94
				           g: 0.94
				           b: 0.94
				           alpha: 1.0);
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		          addEventHandlerOn: BlClickEvent do: [ :e |
			          e consume.
			          Clipboard clipboardText: valueElt text asString.
			          self inform: 'Hex code copied to clipboard' ];
		          yourself.

	self addChild: hexElt.

	valueElt := BlTextElement new
		            padding: (BlInsets all: 10);
		            margin: (BlInsets left: 5);
		            text: 'FF0000' asRopedText;
		            background: (Color
				             r: 0.94
				             g: 0.94
				             b: 0.94
				             alpha: 1.0);
		            geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		            size: 40 @ 10.

	self addChild: valueElt
]

{ #category : #accessing }
BlHexTextElement >> owner: anElement [ 

	owner := anElement 
]

{ #category : #'as yet unclassified' }
BlHexTextElement >> updateHexCode [ 

	valueElt text: owner color asHexString asRopedText
]
