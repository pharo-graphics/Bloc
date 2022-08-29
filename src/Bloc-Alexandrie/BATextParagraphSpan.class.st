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
BATextParagraphSpan >> updateMetricsWithBuilder: aBlTextFontAndStyleBuilder [

	"build an abstract font and resolve not yet resolved properties"

	| utf8Encoded |
	utf8Encoded := self span isTabulation
		               ifTrue: [ '' utf8Encoded  ]
		               ifFalse: [ self span utf8Encoded ].
	self
		updateMetricsFor: utf8Encoded
		builder: aBlTextFontAndStyleBuilder
		canvas: hostMeasurer canvas.
	ascent := metrics at: #ascent.
	descent := metrics at: #descent.
	advance := metrics at: #advance.
	left := metrics at: #left.
	top := metrics at: #top.
	width := metrics at: #width.
	height := metrics at: #height
]
