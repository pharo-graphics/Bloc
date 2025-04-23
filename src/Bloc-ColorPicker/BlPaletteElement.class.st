"
I am a Palette Element designed for a Color Picker.

I display a selection of basic colors you can click to modify the current color.
"
Class {
	#name : #BlPaletteElement,
	#superclass : #BlElement,
	#instVars : [
		'owner'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #adding }
BlPaletteElement >> addColor: aColor [

	| newElt |
	newElt := BlElement new
		          size: 20 asPoint;
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
					margin: (BlInsets all: 5);
		          background: aColor;
		          yourself.
	newElt addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		owner setColor: aColor ].
	self addChild: newElt
]

{ #category : #initialization }
BlPaletteElement >> initialize [
	
	super initialize.
	self layout: BlFlowLayout new.
	self width: 250.
	self constraintsDo: [ :c |
		c margin: (BlInsets horizontal: 10 vertical: 5).
		c vertical fitContent ].
	self initializeBasicPalette
]

{ #category : #initialization }
BlPaletteElement >> initializeBasicPalette [

	| palette |
	palette := {
		           Color white.
		           Color gray.
		           Color black.
		           Color red.
		           Color green.
		           Color blue.
		           Color yellow.
		           Color cyan.
		           Color magenta.
		           Color orange.
		           Color purple.
		           Color brown.
		           Color pink }.

	palette do: [ :color | self addColor: color ]
]

{ #category : #accessing }
BlPaletteElement >> owner: anElement [ 

	owner := anElement 
]
