"
I represent a paragraph line and consist of spans.

Width of the line is not a plain sum of width of all spans. The difference comes from the fact that because of Kerning advance of a piece of text is less than visual width of the same text.

"
Class {
	#name : #BlTextParagraphLine,
	#superclass : #BlTextParagraphSegment,
	#instVars : [
		'spans'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'instance creation' }
BlTextParagraphLine class >> rope: aRope spans: aSpansCollection [
	^ self new
		rope: aRope spans: aSpansCollection;
		yourself
]

{ #category : #'instance creation' }
BlTextParagraphLine class >> spans: aSpansCollection [
	^ self new
		spans: aSpansCollection;
		yourself
]

{ #category : #adding }
BlTextParagraphLine >> addSpan: aBrTextParagraphSpan [
	spans add: aBrTextParagraphSpan.
	aBrTextParagraphSpan paragraph: self paragraph.

	spans size = 1
		ifTrue: [ self spanAdded: spans first ]
		ifFalse: [ self spanAdded: spans last after: (spans at: spans size - 1) ]
]

{ #category : #accessing }
BlTextParagraphLine >> baseline: aPoint [

	self moveSpansBy: self baseline negated.
	super baseline: aPoint.
	self moveSpansBy: self baseline
]

{ #category : #finalization }
BlTextParagraphLine >> finalize [

	spans do: #finalize.
	spans := OrderedCollection new
]

{ #category : #initialization }
BlTextParagraphLine >> initialize [
	super initialize.
	
	spans := OrderedCollection new
]

{ #category : #testing }
BlTextParagraphLine >> isEmpty [
	<return: #Boolean>
	
	^ self spans isEmpty
]

{ #category : #private }
BlTextParagraphLine >> moveSpansBy: aPoint [
	"Move baseline of all spans by a given delta as a point"

	self spans do: [ :aSpan | aSpan baseline: aSpan baseline + aPoint ]
]

{ #category : #measurement }
BlTextParagraphLine >> normalize: aScale [
	"Normalize this segment to have rounded measurements.
	I don't change the baseline"

	spans
		ifEmpty: [ ^ self ].
		
	spans do: [ :aSpan | aSpan normalize: aScale ].
	
	self recomputeLineLayout
]

{ #category : #measurement }
BlTextParagraphLine >> recomputeLineLayout [

	self spans
		ifEmpty: [ ^ self ].

	self spanAdded: self spans first.	
	2 to: self spans size do:
		[ :index | self spanAdded: (self spans at: index) after: (self spans at: index - 1) ]
]

{ #category : #hooks }
BlTextParagraphLine >> spanAdded: aSpan [
	
	self
		assert: [ aSpan == spans first ]
		description: [ 'I can only be sent with the first span as argument' ].

	left := aSpan left.
	top := aSpan top.
	width := aSpan width.
	height := aSpan height.
	advance := aSpan advance.
	
	ascent := aSpan ascent.
	descent := aSpan descent.

	from := aSpan from.
	to := aSpan to.
	
	aSpan baseline: self baseline
]

{ #category : #hooks }
BlTextParagraphLine >> spanAdded: aLastSpan after: aPreviousSpan [
	aLastSpan isVertical
		ifTrue: [ aPreviousSpan isVertical
			ifTrue: [ self spanAddedVertical: aLastSpan afterVertical: aPreviousSpan ]
			ifFalse: [ self spanAddedVertical: aLastSpan afterHorizontal: aPreviousSpan ] ]
		ifFalse: [ aPreviousSpan isVertical
			ifTrue: [ self spanAddedHorizontal: aLastSpan afterVertical: aPreviousSpan ]
			ifFalse: [ self spanAddedHorizontal: aLastSpan afterHorizontal: aPreviousSpan ] ]
]

{ #category : #hooks }
BlTextParagraphLine >> spanAddedHorizontal: aLastSpan afterHorizontal: aPreviousSpan [
	| previousBottom newBottom |

	aLastSpan baseline: aPreviousSpan baseline + (aPreviousSpan advance @ 0).

	previousBottom := top + height.
	newBottom := aLastSpan top + aLastSpan height.
	top := top min: aLastSpan top.
	height := height max: ((previousBottom max: newBottom) - top).

	width := aLastSpan baseline x + aLastSpan left + aLastSpan width.
	advance := advance + aLastSpan advance.

	ascent := ascent min: aLastSpan ascent.
	descent := descent max: aLastSpan descent.

	to := aLastSpan to
]

{ #category : #hooks }
BlTextParagraphLine >> spanAddedHorizontal: aLastSpan afterVertical: aPreviousSpan [
	self shouldBeImplemented
]

{ #category : #hooks }
BlTextParagraphLine >> spanAddedVertical: aLastSpan afterHorizontal: aPreviousSpan [
	self shouldBeImplemented
]

{ #category : #hooks }
BlTextParagraphLine >> spanAddedVertical: aLastSpan afterVertical: aPreviousSpan [
	self shouldBeImplemented
]

{ #category : #accessing }
BlTextParagraphLine >> spans [
	<return: #SequenceableCollection of: #BlTextParagraphSpan>

	^ spans
]
