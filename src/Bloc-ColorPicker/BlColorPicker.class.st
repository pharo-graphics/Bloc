"
I am a Color Picker for Bloc.

I own different elements that allow the creation of a Color for you to use.

My main elements are :
- a Color Map : handling saturation and brightness of a hue.
- a Color Slider : selecting a hue.
- an Alpha Slider : modifying the transparency of the Color.
- a Preview Element : showing the current Color you are working on.
- RGB/Hex code text elements : displaying the numerical values of the current Color.
- a Color Palette : displaying basic colors you can select.
"
Class {
	#name : #BlColorPicker,
	#superclass : #BlElement,
	#instVars : [
		'colorMap',
		'colorSlider',
		'alphaSlider',
		'color',
		'alpha',
		'previewElement',
		'rgbTextElt',
		'hexTextElt',
		'alphaTextElt',
		'colorPalette'
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
	self initializeTextElements.
	self initializeColorPalette.
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
BlColorPicker >> initializeAlphaTextElements [

	alphaTextElt := BlAlphaTextElement new owner: self.
]

{ #category : #initialization }
BlColorPicker >> initializeColorMap [

	colorMap := BlColorMap new owner: self; yourself .
	self addChild: colorMap
]

{ #category : #initialization }
BlColorPicker >> initializeColorPalette [ 

	colorPalette := BlPaletteElement new owner: self.
	self addChild: colorPalette
]

{ #category : #initialization }
BlColorPicker >> initializeColorSlider [

	colorSlider := BlColorSlider new
		               owner: self;
		               yourself.
]

{ #category : #initialization }
BlColorPicker >> initializeHexTextElements [

	hexTextElt := BlHexTextElement new owner: self.
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

	previewElement
		addEventHandlerOn: BlClickEvent
		do: [ :e | self inform: 'Color copied to clipboard'.
			Clipboard clipboardText: self colorWithAlpha asString ].
	previewElementParent addChild: previewElement.
	^ previewElementParent
]

{ #category : #initialization }
BlColorPicker >> initializeRGBTextElements [

	rgbTextElt := BlRGBTextElement new owner: self.
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

{ #category : #initialization }
BlColorPicker >> initializeTextElements [

	| linearLayoutElement |
	self initializeRGBTextElements.
	self addChild: rgbTextElt.
	linearLayoutElement := BlElement new
		                       layout: BlLinearLayout horizontal;
		                       constraintsDo: [ :c |
			                       c vertical fitContent.
			                       c horizontal fitContent ];
		                       yourself.
	self initializeHexTextElements.
	self initializeAlphaTextElements.
	linearLayoutElement addChildren: {
			hexTextElt.
			alphaTextElt }.
	self addChild: linearLayoutElement
]

{ #category : #accessing }
BlColorPicker >> setColor: aColor [

	colorMap setColor: aColor.
	self updateColor
]

{ #category : #updating }
BlColorPicker >> updateAlpha [
	"update alpha % and preview"

	alpha := alphaSlider alpha.
	alphaTextElt updateAlphaCode.
	self updatePreview
]

{ #category : #updating }
BlColorPicker >> updateColor [
	"redefines RGB / Hex code + preview element"

	color := colorMap color.
	alphaSlider setColor: color.
	rgbTextElt updateRGBCode.
	hexTextElt updateHexCode.
	self updatePreview
]

{ #category : #updating }
BlColorPicker >> updateHue [

	colorMap setHue: colorSlider hue.
	self updateColor
]

{ #category : #updating }
BlColorPicker >> updatePreview [
	
	previewElement background: self colorWithAlpha 
]

{ #category : #updating }
BlColorPicker >> updateSliderCursor [

	colorSlider updateCursor
]
