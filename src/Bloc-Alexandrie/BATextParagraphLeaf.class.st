Class {
	#name : #BATextParagraphLeaf,
	#superclass : #BlTextParagraphSegmentLeaf,
	#instVars : [
		'metrics',
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder'
	],
	#classVars : [
		'TabStopWidth'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BATextParagraphLeaf class >> tabStopWidth [
	^ TabStopWidth ifNil: [ TabStopWidth := 36 ]
]

{ #category : #accessing }
BATextParagraphLeaf class >> tabStopWidth: anInteger [
	TabStopWidth := anInteger
]

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

{ #category : #accessing }
BATextParagraphLeaf >> tabStopWidth [
	^ self class tabStopWidth
]

{ #category : #building }
BATextParagraphLeaf >> updateMetricsFor: utf8EncodedString builder: aBlTextFontAndStyleBuilder canvas: aeCanvas [

	"Return a font metrics dictionary from an abstract font"

	| buffer aBlFont |
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder.
	aBlFont := fontAndStyleBuilder font.
	cairoScaledFont := aeCanvas scaledFontForFace: aBlFont asAeFTFace size: aBlFont fontSize value.

	"Get glyphs for the text"
	buffer := utf8EncodedString.
	cairoGlyphsArray := cairoScaledFont glyphArrayFor: buffer length: buffer size.

	metrics at: #ascent put: cairoScaledFont extents ascent negated.
	metrics at: #descent put: cairoScaledFont extents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"

	aeCanvas textExtentsFor: cairoGlyphsArray scaledFont: cairoScaledFont do: [ :aTextExtents | 
		span isTabulation
			ifTrue: [ metrics at: #advance put: self tabStopWidth ]
			ifFalse: [ metrics at: #advance put: aTextExtents advanceX ].
		metrics at: #left put: aTextExtents bearingX.
		metrics at: #top put: aTextExtents bearingY.
		span isTabulation
			ifTrue: [ metrics at: #width put: self tabStopWidth ]
			ifFalse: [ metrics at: #width put: aTextExtents width ].
		metrics at: #height put: aTextExtents height.
		metrics
			at: #bounds
			put: (aTextExtents bearingX @ aTextExtents bearingY extent: (metrics at: #width) @ aTextExtents height) ]
]
