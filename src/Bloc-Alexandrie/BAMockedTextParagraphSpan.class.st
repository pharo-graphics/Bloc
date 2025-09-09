Class {
	#name : #BAMockedTextParagraphSpan,
	#superclass : #BATextParagraphLeaf,
	#category : #'Bloc-Alexandrie-Text-Mocked'
}

{ #category : #drawing }
BAMockedTextParagraphSpan >> aeDrawOn: aeCanvas [

	| characterWidth characterHeight aBlFont aFace |
	self spanLength isZero ifTrue: [ ^ self ].

	aBlFont := fontAndStyleBuilder font.
	aFace := aBlFont asAeCairoFontFace.
	cairoScaledFont := aeCanvas
		scaledFontFor: aFace
		size: aBlFont fontSize value.

	"Get glyphs for the text"
	characterWidth := (self width / self spanLength) asFloat.
	characterHeight := self height.

	" Draw each character one by one"
	self span asString withIndexDo: [ :c :index | 
		| metrics bounds measuredWidth heightScale measuredHeight eachBaseline fixedBounds |
		eachBaseline := (self baseline + ((index - 1) * (characterWidth @ 0))) x @ 0.
		"Get glyphs for the text"
		cairoGlyphsArray := cairoScaledFont glyphArrayForString: c asString.
		metrics := aeCanvas metricsFor: cairoGlyphsArray font: cairoScaledFont.
		bounds := metrics bearingX @ metrics bearingY extent: metrics width @ metrics height.
		measuredWidth := bounds width.
		measuredWidth isZero ifTrue: [ measuredWidth := characterWidth ].
		measuredHeight := metrics ascent abs + metrics descent.
		measuredHeight isZero ifTrue: [ measuredHeight := characterHeight ].
		heightScale := characterHeight * 0.8 / measuredHeight.
		fixedBounds := eachBaseline extent: characterWidth @ characterHeight.
		aeCanvas setSourceColor: (fontAndStyleBuilder hasCustomColor
				 ifTrue: [ fontAndStyleBuilder color ]
				 ifFalse: [ Color black ]).

		"Draw the border around the character"
		aeCanvas restoreContextAfter: [ 
			"aeCanvas setBackgroundOff."
			" setOutskirtsInside otherwise the cursor is hidden"
			aeCanvas pathFactory: [ :cairoContext |
				cairoContext rectangle: fixedBounds ].
			Color random asBlPaint aeApplyAsBackgroundTo: aeCanvas opacity: 0.4.
			aeCanvas setOutskirtsInside.
			aeCanvas setBorderBlock: [ 
				aeCanvas setSourceColor: Color veryVeryLightGray lighter.
				aeCanvas setBorderWidth: 1.0 ].
			aeCanvas drawFigure ].

		"Draw the current character"
		aeCanvas restoreContextAfter: [ 
			aeCanvas pathTranslate: eachBaseline.
			aeCanvas pathScale: heightScale asPoint.
			aeCanvas pathTranslate:
				bounds origin x negated @ metrics ascent abs + (characterWidth / heightScale - bounds width / 2.0 @ 0).
			self attributes do: [ :anAttribute | anAttribute aeDrawBelowOn: aeCanvas span: self ].
			aeCanvas drawGlyphs: cairoGlyphsArray font: cairoScaledFont ].

		"Draw the textOffset "
		aeCanvas restoreContextAfter: [ 
			| idxScaledFont idxGlyphsArray |
			aeCanvas setSourceColor: Color gray.
			idxScaledFont := aeCanvas
				scaledFontForFace: aFace
				size: characterHeight * 0.32.
			idxGlyphsArray := idxScaledFont glyphArrayForString: (index + hostMeasurer textOffset - 1) asString.
			index = 1 ifTrue: [ 
				aeCanvas restoreContextAfter: [ 
					aeCanvas pathTranslate: eachBaseline x + 1 @ (self height - 1).
					aeCanvas drawGlyphs: idxGlyphsArray font: idxScaledFont ] ].
			idxGlyphsArray := idxScaledFont glyphArrayForString: (index + hostMeasurer textOffset) asString.
			aeCanvas restoreContextAfter: [ 
				aeCanvas pathTranslate: eachBaseline x + characterWidth + 1 @ (self height - 1).
				aeCanvas drawGlyphs: idxGlyphsArray font: idxScaledFont ] ] ].

	self attributes do: [ :anAttribute | anAttribute aeDrawAboveOn: aeCanvas span: self ]
]

{ #category : #building }
BAMockedTextParagraphSpan >> measure [

	width := hostMeasurer measuredWidth.
	height := hostMeasurer measuredHeight.
	
	ascent := hostMeasurer ascent.
	descent := hostMeasurer descent.

	left := 0.
	top := 0.
	advance := width.
	
	baseline := 0@0
]
