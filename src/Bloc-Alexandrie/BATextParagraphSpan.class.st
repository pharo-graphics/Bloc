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
			anAttribute aeDrawBelowOn: aeCanvas span: self
			"			anAttribute aeApplyTo: aeCanvas " ].

		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont.

		self attributes do: [ :anAttribute | 
			anAttribute aeDrawAboveOn: aeCanvas span: self ] ]
]

{ #category : #building }
BATextParagraphSpan >> updateMetrics [

	"build an abstract font and resolve not yet resolved properties"

	| utf8Encoded metrics canvas font |

	canvas := hostMeasurer canvas.

	utf8Encoded := self span isTabulation
		               ifTrue: [ '' utf8Encoded ]
		               ifFalse: [ self span utf8Encoded ].

	font := fontAndStyleBuilder font.
	cairoScaledFont := canvas scaledFontForFace: font asAeFTFace size: font fontSize value.
	cairoGlyphsArray := cairoScaledFont glyphArrayFor: utf8Encoded length: utf8Encoded size.
	metrics := canvas metricsFor: cairoGlyphsArray font: cairoScaledFont.

	baseline := 0 @ 0.
	ascent := metrics ascent.
	descent := metrics descent.
	left := metrics bearingX.
	top := metrics bearingY.
	height := metrics height.
	self span isTabulation
		ifTrue: [ 
			advance := self tabStopWidth.
			width := self tabStopWidth ]
		ifFalse: [ 
			advance := metrics advanceX.
			width := metrics width ]
]
