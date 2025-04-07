Extension { #name : #BlRowNumberDecoration }

{ #category : #'*Bloc-Alexandrie' }
BlRowNumberDecoration >> aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement [
	" draw the line number "

	| holder index cairoScaledFont cairoGlyphsArray fontExtents h |
	super aeDraw: anItemElement overOn: aeCanvas in: anInfiniteElement.
	anItemElement height < 1 ifTrue: [ ^ self ].
	aeCanvas restoreContextAfter: [
		holder := anInfiniteElement childHolderOf: anItemElement.
		index := holder position.
		cairoScaledFont := self aeCairoScaledFontOn: aeCanvas in: anInfiniteElement.
		fontExtents := cairoScaledFont fontExtents.
		h := self
			     numberVerticalHeightIn: anItemElement
			     fontHeight: fontExtents height.
		aeCanvas pathTranslate:
			self numberLeftGap @ (anItemElement bounds inParent top + fontExtents ascent + h).
		aeCanvas setSourceColor: Color gray darker.
		cairoGlyphsArray := cairoScaledFont glyphArrayForString:
			                    index asString.
		aeCanvas drawGlyphs: cairoGlyphsArray font: cairoScaledFont ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRowNumberDecoration >> aeMeasuredActualWidthFor: aNumber on: aeCanvas in: anInfiniteElement [
	" return the necessary width according to the line number.
	Based on Alexandrie text measurement   "

	| holder cairoScaledFont fontExtents cairoGlyphsArray |
	anInfiniteElement hasChildren ifFalse: [ ^ 0 ].
	holder := anInfiniteElement childHolderOf:
		          anInfiniteElement children last.
	cairoScaledFont := self aeCairoScaledFontOn: aeCanvas in: anInfiniteElement.
	fontExtents := cairoScaledFont fontExtents.
	cairoGlyphsArray := cairoScaledFont glyphArrayForString:
		                    aNumber asString.
	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents | ^ aTextExtents width + 10 ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRowNumberDecoration >> aeMeasuredWidthOn: aeCanvas in: anInfiniteElement [

	| nb |
	nb := anInfiniteElement hasChildren
		      ifTrue: [
			      (anInfiniteElement childHolderOf:
				       anInfiniteElement children last) position ]
		      ifFalse: [ 0 ].
	^ self
		aeMeasuredActualWidthFor: (nb max: 99)
		on: aeCanvas
		in: anInfiniteElement
]
