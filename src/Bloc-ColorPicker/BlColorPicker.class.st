Class {
	#name : #BlColorPicker,
	#superclass : #BlElement,
	#instVars : [
		'colorMap',
		'colorSlider',
		'alphaSlider',
		'color',
		'alpha',
		'previewElement'
	],
	#category : #'Bloc-ColorPicker'
}

{ #category : #'instance creation' }
BlColorPicker class >> open [ 

	<script> 
	
	self new openInSpace
]

{ #category : #accessing }
BlColorPicker >> alpha [ 

	^ alpha 
]

{ #category : #accessing }
BlColorPicker >> color [ 

	^ color
]

{ #category : #accessing }
BlColorPicker >> colorWithAlpha [ 

	^ color alpha: alpha
]

{ #category : #initialization }
BlColorPicker >> initialize [

	super initialize.
	self background: Color veryVeryLightGray.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
	self constraintsDo: [ :c |
		c padding: (BlInsets all: 30).
		c horizontal fitContent.
		c vertical fitContent ].
	self layout: BlLinearLayout vertical.
	color := Color red.
	alpha := 1.
	self initializeColorMap.
	self initializeSlidersAndPreview.
"	self initializeColorSlider.
	self initializeAlphaSlider.
	self initializePreviewElement"
]

{ #category : #initialization }
BlColorPicker >> initializeAlphaSlider [

	alphaSlider := BlAlphaSlider new
		               owner: self;
		               yourself.
]

{ #category : #initialization }
BlColorPicker >> initializeColorMap [

	colorMap := BlColorMap new owner: self; yourself .
	self addChild: colorMap
]

{ #category : #initialization }
BlColorPicker >> initializeColorSlider [

	colorSlider := BlColorSlider new
		               owner: self;
		               yourself.
]

{ #category : #initialization }
BlColorPicker >> initializePreviewElement [

	| previewElementParent |
	previewElementParent := BlElement new
		                        size: 50 asPoint;
		                        geometry:
			                        (BlRoundedRectangleGeometry cornerRadius:
					                         10);
		                        constraintsDo: [ :c |
			                        c margin: (BlInsets all: 10) ];
		                        border:
			                        (BlBorder paint: Color black width: 2).

	previewElementParent addChild:
		(BlAlphaSlider chessBackgroundFor: 50 asPoint squareSize: 10).

	previewElement := BlElement new
		                  constraintsDo: [ :c |
			                  c vertical matchParent.
			                  c horizontal matchParent ];
		                  background: self colorWithAlpha;
		                  yourself.
	previewElementParent addChild: previewElement.
	^ previewElementParent
]

{ #category : #initialization }
BlColorPicker >> initializeSlidersAndPreview [

	| container slidersContainer previewParent |
	container := BlElement new
		             constraintsDo: [ :c |
			             c vertical fitContent.
			             c horizontal fitContent ];
		             layout: BlLinearLayout horizontal;
		             yourself.

	slidersContainer := BlElement new
		                    constraintsDo: [ :c |
			                    c vertical fitContent.
			                    c horizontal fitContent ];
		                    layout: BlLinearLayout vertical;
		                    yourself.

	self initializeColorSlider.
	self initializeAlphaSlider.
	slidersContainer addChildren: {
			colorSlider.
			alphaSlider }.

	previewParent := self initializePreviewElement.
	container addChildren: {
			slidersContainer.
			previewParent }.
			
	self addChild: container
]

{ #category : #updating }
BlColorPicker >> updateAlpha [
	"update alpha % and preview"

	alpha := alphaSlider alpha.
	self updatePreview.
]

{ #category : #updating }
BlColorPicker >> updateColor [
	"redefines RGB / Hex code + preview element"

	color := colorMap color.
	self updatePreview.
]

{ #category : #updating }
BlColorPicker >> updateHue [

	colorMap setHue: colorSlider hue.
	alphaSlider setHue: colorSlider hue.
	self updateColor.
]

{ #category : #actions }
BlColorPicker >> updatePreview [
	
	previewElement background: self colorWithAlpha 
]
