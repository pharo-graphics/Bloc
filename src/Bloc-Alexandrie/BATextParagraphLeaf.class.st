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

{ #category : #measurement }
BATextParagraphLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'Do we need this ?'.

]

{ #category : #building }
BATextParagraphLeaf >> span: aBlSpan fontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	self span: aBlSpan.
	self fontAndStyleBuilder: aBlTextFontAndStyleBuilder	
]

{ #category : #accessing }
BATextParagraphLeaf >> tabStopWidth [
	^ self class tabStopWidth
]
