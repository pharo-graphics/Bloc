Class {
	#name : #BlRowNumberDecoration,
	#superclass : #BlInfinteSideDecoration,
	#instVars : [
		'actualWidth'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeCairoScaledFontOn: aeCanvas [

	| fontAndStyleBuilder freeTypeFont |
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	freeTypeFont := fontAndStyleBuilder font asAeFTFace.
	^ aeCanvas scaledFontForFace: freeTypeFont size: 12
]

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement [

	| holder index cairoScaledFont cairoGlyphsArray fontExtents h |
	super aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement.
	anItemElement height < 1 ifTrue: [ ^ self ].
	aeCanvas restoreContextAfter: [
		holder := anInfiniteElement childHolderOf: anItemElement.
		index := holder layoutPosition.
		cairoScaledFont := self aeCairoScaledFontOn: aeCanvas.
		fontExtents := cairoScaledFont fontExtents.
		h := self
			     numberVerticalHeightIn: anItemElement
			     fontHeight: fontExtents height.
		aeCanvas pathTranslate:
			4 @ (anItemElement bounds inParent top + fontExtents ascent + h).
		aeCanvas setSourceColor: Color gray darker.
		cairoGlyphsArray := cairoScaledFont glyphArrayForString:
			                    index asString.
		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont ]
]

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeDrawBackgroundOn: aeCanvas in: anInfiniteElement [

	"draw the background beneath "

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext rectangle: self computedBounds ].
	aeCanvas
		setBackgroundWith: [ aeCanvas setSourceColor: Color veryLightGray ]
		alpha: 0.10.
	aeCanvas setBorderOff.
	aeCanvas drawFigure
]

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeDrawBeneathOn: aeCanvas in: anInfiniteElement [

	"Update the actual width and draw the background beneath "

	self aeMeasureActualWidthOn: aeCanvas in: anInfiniteElement.
	aeCanvas restoreContextAfter: [ self aeDrawBackgroundOn: aeCanvas in: anInfiniteElement ].
	"super sent ensure drawing for item elements"
	super aeDrawBeneathOn: aeCanvas in: anInfiniteElement
]

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeMeasureActualWidthFor: aNumber on: aeCanvas in: anInfiniteElement [
	"Draw the background beneath "

	| holder cairoScaledFont fontExtents cairoGlyphsArray |
	anInfiniteElement hasChildren ifFalse: [ ^ self ].
	holder := anInfiniteElement childHolderOf:
		          anInfiniteElement children last.
	cairoScaledFont := self aeCairoScaledFontOn: aeCanvas.
	fontExtents := cairoScaledFont fontExtents.
	cairoGlyphsArray := cairoScaledFont glyphArrayForString:
		                    aNumber asString.
	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents |
			self
				onActualWidthChangeWith: aTextExtents width + 10
				do: [ anInfiniteElement requestLayout ] ]
]

{ #category : #'as yet unclassified' }
BlRowNumberDecoration >> aeMeasureActualWidthOn: aeCanvas in: anInfiniteElement [

	| nb |
	nb := anInfiniteElement hasChildren ifTrue: [ (anInfiniteElement childHolderOf: anInfiniteElement children last) layoutPosition ] ifFalse: [ 99 ].
	self aeMeasureActualWidthFor: nb asString on: aeCanvas in: anInfiniteElement
]

{ #category : #initialization }
BlRowNumberDecoration >> defaultWidth [
	^ 21
]

{ #category : #initialization }
BlRowNumberDecoration >> initialize [
	super initialize.
	actualWidth := self defaultWidth.
	"highest priority"
	priority := 0
]

{ #category : #geometry }
BlRowNumberDecoration >> numberVerticalHeightIn: anItemElement fontHeight: fontHeight [

	" By default, the row number is centered vertically"
	^ (anItemElement height - fontHeight) / 2
]

{ #category : #geometry }
BlRowNumberDecoration >> onActualWidthChangeWith: anInteger do: aBlock [

	anInteger <= actualWidth ifTrue: [ ^ self ].
	actualWidth := anInteger.
	aBlock value
]

{ #category : #geometry }
BlRowNumberDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [

	^ BlInsets left: self requiredWidth + anInfiniteElement margin left
]

{ #category : #geometry }
BlRowNumberDecoration >> requiredWidth [

	^ actualWidth  
]
