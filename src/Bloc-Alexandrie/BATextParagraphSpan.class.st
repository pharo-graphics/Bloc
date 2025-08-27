"
I represent an Alexandrie specific measured span
"
Class {
	#name : #BATextParagraphSpan,
	#superclass : #BATextParagraphLeaf,
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #drawing }
BATextParagraphSpan >> aeDrawOn: aeCanvas [

	self span ifNil: [ ^ self ].
	aeCanvas restoreContextAfter: [
		aeCanvas pathTranslate: self baseline.
		self flag: #todo. "Default color?"
		aeCanvas setSourceColor: (fontAndStyleBuilder hasCustomColor
				 ifTrue: [ fontAndStyleBuilder color ]
				 ifFalse: [ Color black ]).

		self attributes do: [ :anAttribute |
			anAttribute aeDrawBelowOn: aeCanvas span: self ].

		aeCanvas drawGlyphs: cairoGlyphsArray font: cairoScaledFont.

		self attributes do: [ :anAttribute |
			anAttribute aeDrawAboveOn: aeCanvas span: self ] ]
]

{ #category : #drawing }
BATextParagraphSpan >> appendPathOn: aeCanvas [

	aeCanvas appendGlyphsPath: cairoGlyphsArray font: cairoScaledFont
]

{ #category : #building }
BATextParagraphSpan >> measure [

	"build an abstract font and resolve not yet resolved properties"

	| metrics canvas font usedSpan fontSize |
	canvas := hostMeasurer canvas.

	usedSpan := self span isTabulation
		            ifTrue: [ '' ]
		            ifFalse: [ self span ].

	font := fontAndStyleBuilder font.
	fontSize := font fontSize value.

	"Without Harfbuzz:"
"	cairoScaledFont := canvas scaledFontForFace: font asAeFTFace size: fontSize."

	"With Harfbuzz:"
	cairoScaledFont := canvas scaledFontForHbFont: font asAeHbFont size: fontSize.

	"Common"
	cairoGlyphsArray := cairoScaledFont glyphArrayForString: usedSpan.
	metrics := canvas metricsFor: cairoGlyphsArray font: cairoScaledFont.
	baseline := 0 @ 0.
	ascent := metrics ascent.
	descent := metrics descent.
	left := metrics bearingX "ceiling". ""
	top := metrics bearingY "floor".    ""
	height := metrics height.
	self span isTabulation
		ifTrue: [ 
			advance := self tabStopWidth.
			width := self tabStopWidth ]
		ifFalse: [ 
			advance := metrics advanceX.
			width := metrics width ].

"	Halt once. "
]
