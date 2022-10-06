Class {
	#name : #BATextParagraphLeaf,
	#superclass : #BlTextParagraphSegmentLeaf,
	#instVars : [
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
	self subclassResponsibility 
]

{ #category : #accessing }
BATextParagraphLeaf >> fontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder 
]

{ #category : #building }
BATextParagraphLeaf >> measureWith: aBATextMeasurer [
	^ self subclassResponsibility 
]

{ #category : #measurement }
BATextParagraphLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'Do we need this ?'.

]

{ #category : #building }
BATextParagraphLeaf >> setupFromHostTextMeasurer: aBATextMeasurer forSpan: aBlSpan [

	self fontAndStyleBuilder: BlTextFontAndStyleBuilder new.
	self span: aBlSpan.

	"Collect font properties and text style from the attributes"
	self span attributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].
	self measureWith: aBATextMeasurer
]

{ #category : #accessing }
BATextParagraphLeaf >> tabStopWidth [
	^ self class tabStopWidth
]
