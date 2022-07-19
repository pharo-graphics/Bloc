"
I represent a single measured span within `=BrTextParagraph`=.
Depending on the type of a paragraph (single or multi line) I can be either a direct child of `=BrTextParagraph`= or be contained inside of `=BrTextParagraphLine`=.

A span consists of 3 essential parts:

	- underlying text span with span start and end indices
	- generated glyph text run with start and end indices used for measurement and rendering
	- various measurement metrics computed during measurement step by `=BrTextParagraphSpanMeasurer`=

"
Class {
	#name : #BlTextParagraphSpan,
	#superclass : #BlTextParagraphLeaf,
	#instVars : [
		'textRun',
		'strikethroughOffset',
		'strikethroughSize'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #initialization }
BlTextParagraphSpan >> applyFixedMetrics: aSpanMeasurer [

	width := aSpanMeasurer measuredWidth.
	height := aSpanMeasurer measuredHeight.
	
	ascent := aSpanMeasurer ascent.
	descent := aSpanMeasurer descent.

	strikethroughOffset := 0.
	strikethroughSize := 1.

	left := 0.
	top := 0.
	advance := width.
	
	baseline := 0@0
]

{ #category : #finalization }
BlTextParagraphSpan >> finalize [

	textRun ifNotNil: [ :aTextRun | aTextRun release ].
	textRun := nil
]

{ #category : #measurement }
BlTextParagraphSpan >> normalize: aScale [
	"Normalize this segment to have rounded measurements"

	| newLeft newTop |
	newLeft := left floorTicks: aScale.
	newTop := top floorTicks: aScale.

	width := (left - newLeft + width) ceilingTicks: aScale.
	height := (top - newTop + height) ceilingTicks: aScale.

	left := newLeft.
	top := newTop.

	advance := advance ceilingTicks: aScale
]

{ #category : #accessing }
BlTextParagraphSpan >> paragraph: aTextParagraph [

	super paragraph: aTextParagraph.

	self attributes do: [ :eachAttribute | 
		eachAttribute
			applyOnTextParagraph: aTextParagraph
			from: self from
			to: self to ]
]

{ #category : #accessing }
BlTextParagraphSpan >> strikethroughOffset [

	^ strikethroughOffset
]

{ #category : #accessing }
BlTextParagraphSpan >> strikethroughSize [

	^ strikethroughSize
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRun [

	^ textRun
]

{ #category : #initialization }
BlTextParagraphSpan >> textRun: aTextRun [
	"Assign a backend specific text run (collection of glyphs) with corresponding
	start and end indices which represents an unstyled piece of text"
	
	textRun := aTextRun.
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunEnd [
	"Return an index of a last measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ textRun size
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunLength [
	"Return how many glyphs I represent of a text run according
	to text run start and end indices. It is guaranteed that during
	rendering only this amount of glyphs will be rendered.
	Note: glyphs can be complex, meaning that they consist of multiple simple glyphs,
	that is why text run length always equal or greater than span length"
	<return: #Number>
	
	^ (self textRunStart isZero and: [ self textRunEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self textRunEnd - self textRunStart + 1 ]
]

{ #category : #'accessing - text run' }
BlTextParagraphSpan >> textRunStart [
	"Return an index of a first measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ 1 min: textRun size
]
