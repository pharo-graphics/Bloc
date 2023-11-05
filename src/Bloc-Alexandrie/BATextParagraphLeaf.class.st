Class {
	#name : 'BATextParagraphLeaf',
	#superclass : 'BlTextParagraphSegmentLeaf',
	#instVars : [
		'cairoScaledFont',
		'cairoGlyphsArray'
	],
	#classVars : [
		'TabStopWidth'
	],
	#category : 'Bloc-Alexandrie-Text'
}

{ #category : 'accessing' }
BATextParagraphLeaf class >> tabStopWidth [
	^ TabStopWidth ifNil: [ TabStopWidth := 36 ]
]

{ #category : 'accessing' }
BATextParagraphLeaf class >> tabStopWidth: anInteger [
	TabStopWidth := anInteger
]

{ #category : 'drawing' }
BATextParagraphLeaf >> aeDrawOn: aeCanvas [

	self subclassResponsibility
]

{ #category : 'accessing' }
BATextParagraphLeaf >> tabStopWidth [
	^ self class tabStopWidth
]
