Class {
	#name : #BATextParagraphLeaf,
	#superclass : #BlTextParagraphLeaf,
	#instVars : [
		'metrics',
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder',
		'lineAdvance'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #drawing }
BATextParagraphLeaf >> aeDrawOn: aeCanvas [
]

{ #category : #initialization }
BATextParagraphLeaf >> initialize [
	super initialize.
	metrics := IdentityDictionary new
]

{ #category : #measurement }
BATextParagraphLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'Do we need this ?'.

]

{ #category : #building }
BATextParagraphLeaf >> updateMetricsFor: utf8EncodedString builder: aBlTextFontAndStyleBuilder canvas: aeCanvas [

	"Return a font metrics dictionary from an abstract font"

	| buffer fontExtents aBlFont |
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder.
	aBlFont := fontAndStyleBuilder font.
	cairoScaledFont := aeCanvas
		scaledFontForFace: aBlFont asAeFTFace
		size: aBlFont fontSize value.

	"Get glyphs for the text"
	buffer := utf8EncodedString.
	cairoGlyphsArray := cairoScaledFont glyphArrayFor: buffer length: buffer size.

	fontExtents := aeCanvas fontExtentsOf: cairoScaledFont.

	metrics at: #ascent put: fontExtents ascent negated.
	metrics at: #descent put: fontExtents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"

	aeCanvas textExtentsFor: cairoGlyphsArray scaledFont: cairoScaledFont do: [ :aTextExtents | 
		span isTabulation
			ifTrue: [ metrics at: #advance put: aTextExtents advanceX * 8 ]
			ifFalse: [ metrics at: #advance put: aTextExtents advanceX ].
		metrics at: #left put: aTextExtents bearingX.
		metrics at: #top put: aTextExtents bearingY.
		span isTabulation
			ifTrue: [ metrics at: #width put: aTextExtents width * 8 ]
			ifFalse: [ metrics at: #width put: aTextExtents width ].
		metrics at: #height put: aTextExtents height.
		metrics
			at: #bounds
			put: (aTextExtents bearingX @ aTextExtents bearingY extent: aTextExtents width @ aTextExtents height) ]
]
