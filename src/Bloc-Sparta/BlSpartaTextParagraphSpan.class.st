"
A span consists of 3 essential parts:
	- underlying text span with span start and end indices
	- generated glyph text run with start and end indices used for measurement and rendering
	- various measurement metrics computed during measurement step by `BlTextParagraphMeasurer`

"
Class {
	#name : #BlSpartaTextParagraphSpan,
	#superclass : #BlTextParagraphLeaf,
	#instVars : [
		'strikethroughOffset',
		'strikethroughSize',
		'textRun'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #initialization }
BlSpartaTextParagraphSpan >> applyFixedMetrics: aSpanMeasurer [

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

{ #category : #measurement }
BlSpartaTextParagraphSpan >> applySpartaMetrics: aSpMetrics [

	| aFontMetrics aTextMetrics |
	baseline := 0@0.

	"Set font metrics (which are independendent from the particular string)"
	aFontMetrics := aSpMetrics fontMetrics.
	ascent := aFontMetrics ascent.
	descent := aFontMetrics descent.
	strikethroughOffset := aFontMetrics strikeoutOffset.
	strikethroughSize := aFontMetrics strikeoutSize.

	"Set text metrics (which are particular to a string)"
	aTextMetrics := aSpMetrics textMetrics.
	left :=  aTextMetrics left.
	top := aTextMetrics top.
	width := aTextMetrics width.
	height := aTextMetrics height.
	advance := aTextMetrics advance.

]

{ #category : #drawing }
BlSpartaTextParagraphSpan >> drawOnSpartaCanvas: aCanvas [
	| theAttributes aTextPainter |
	theAttributes := self attributes.
	aTextPainter := aCanvas text.
	theAttributes
		do: [ :anAttribute | 
			anAttribute drawBelowOnSpartaCanvas: aCanvas with: self.
			anAttribute applyOnSpartaTextPainter: aTextPainter ].
	aTextPainter
		text: self textRun;
		baseline: self baseline;
		ensureFont;
		draw.

	"And finally let attributes to render above the text"
	theAttributes
		do:
			[ :anAttribute | anAttribute drawAboveOnSpartaCanvas: aCanvas with: self ]
]

{ #category : #finalization }
BlSpartaTextParagraphSpan >> finalize [

	textRun ifNotNil: [ :aTextRun | aTextRun release ].
	textRun := nil
]

{ #category : #measurement }
BlSpartaTextParagraphSpan >> normalize: aScale [
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
BlSpartaTextParagraphSpan >> strikethroughOffset [

	^ strikethroughOffset
]

{ #category : #accessing }
BlSpartaTextParagraphSpan >> strikethroughSize [

	^ strikethroughSize
]

{ #category : #'accessing - text run' }
BlSpartaTextParagraphSpan >> textRun [

	^ textRun
]

{ #category : #'accessing - text run' }
BlSpartaTextParagraphSpan >> textRun: aTextRun [

	textRun := aTextRun
]

{ #category : #'accessing - text run' }
BlSpartaTextParagraphSpan >> textRunEnd [
	"Return an index of a last measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ textRun size
]

{ #category : #'accessing - text run' }
BlSpartaTextParagraphSpan >> textRunLength [
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
BlSpartaTextParagraphSpan >> textRunStart [
	"Return an index of a first measured glyph in a text run that should be rendered"
	<return: #Number>
	
	^ 1 min: textRun size
]
