Class {
	#name : #BlSideBackgroundDecoration,
	#superclass : #BlInfinteSideDecoration,
	#instVars : [
		'background',
		'actualWidth'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #accessing }
BlSideBackgroundDecoration >> actualWidth [ 

	^ actualWidth 
]

{ #category : #accessing }
BlSideBackgroundDecoration >> aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement [

	^ self computedBounds
]

{ #category : #'as yet unclassified' }
BlSideBackgroundDecoration >> aeCairoScaledFontOn: aeCanvas in: anInfiniteElement [

	| fontAndStyleBuilder freeTypeFont |
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	freeTypeFont := fontAndStyleBuilder font asAeFTFace.
	^ aeCanvas scaledFontForFace: freeTypeFont size: 12
]

{ #category : #'as yet unclassified' }
BlSideBackgroundDecoration >> aeDrawBackgroundOn: aeCanvas in: anInfiniteElement [

	"draw the background beneath "

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext rectangle: (self aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement)  ].
	self background aeApplyTo: aeCanvas.
	aeCanvas setBorderOff.
	aeCanvas drawFigure
]

{ #category : #'as yet unclassified' }
BlSideBackgroundDecoration >> aeDrawBeneathOn: aeCanvas in: anInfiniteElement [
	"Update the actual width and draw the background beneath "

	self aeUpdateWidthOn: aeCanvas in: anInfiniteElement.
	aeCanvas restoreContextAfter: [
		self aeDrawBackgroundOn: aeCanvas in: anInfiniteElement ].
	"super sent ensure drawing for item elements"
	super aeDrawBeneathOn: aeCanvas in: anInfiniteElement
]

{ #category : #'as yet unclassified' }
BlSideBackgroundDecoration >> aeMeasuredWidthOn: aCanvas in: anInfiniteElement [

	" compute and return the actual width. By default, no computing here 
	but subclasses may redefine me to return the necessary width. "
	^ self actualWidth 
]

{ #category : #'as yet unclassified' }
BlSideBackgroundDecoration >> aeUpdateWidthOn: aeCanvas in: anInfiniteElement [

	| width |
	width := self aeMeasuredWidthOn: aeCanvas in: anInfiniteElement.
	width <= self actualWidth ifTrue: [ ^ self ].
	actualWidth := width.
	anInfiniteElement requestLayout
]

{ #category : #accessing }
BlSideBackgroundDecoration >> background [

	^ background ifNil: [background := self defaultBackground ]
]

{ #category : #accessing }
BlSideBackgroundDecoration >> background: aBackground [

	background := aBackground
]

{ #category : #initialization }
BlSideBackgroundDecoration >> defaultBackground [

	^ (Color veryLightGray alpha: 0.10) asBlBackground
]

{ #category : #initialization }
BlSideBackgroundDecoration >> defaultWidth [

	^ 0
]

{ #category : #initialization }
BlSideBackgroundDecoration >> initialize [
	super initialize.
	actualWidth := self defaultWidth.
	"highest priority"
	priority := 0
]

{ #category : #geometry }
BlSideBackgroundDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [

	^ BlInsets left: self requiredWidth + anInfiniteElement margin left
]

{ #category : #geometry }
BlSideBackgroundDecoration >> requiredWidth [

	^ self actualWidth  
]
