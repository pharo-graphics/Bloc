"
I am a span measurer that assignes a fixed extent to every text character ignoring text attributes.

Useful for testing the paragraph behaviour
"
Class {
	#name : #BlTextParagraphFixedSpanMeasurer,
	#superclass : #BlTextParagraphSpanMeasurer,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'ascent',
		'descent',
		'glyphWidth',
		'height',
		'measuredWidth',
		'measuredHeight',
		'textRun',
		'textRunStart',
		'textRunEnd',
		'textOffset'
	],
	#category : #'Bloc-Text-Text-Mocked'
}

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> ascent: aNumber [

	self
		assert: [ aNumber <= 0 ]
		description: [ 'Ascent must be negative' ].

	ascent := aNumber
]

{ #category : #'instance creation' }
BlTextParagraphFixedSpanMeasurer >> createParagraphSpan [
	^ BlTextParagraphFixedSpan new measurer: self
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> descent: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Descent must be positive' ].
	
	descent := aNumber
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> height [
	^ height
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
BlTextParagraphFixedSpanMeasurer >> initialize [
	super initialize.

	ascent := -11.
	descent := 4.
	height := 13.
	glyphWidth := 5
]

{ #category : #measurement }
BlTextParagraphFixedSpanMeasurer >> measureSpan: aBlSpan on: aSpartaCanvas [
	<return: #BlTextParagraphSpan>
	| aTextRun aParagraphSpan |

	aParagraphSpan := self createParagraphSpan.
	aTextRun := (String streamContents: [ :aStream | aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).

	measuredWidth := aTextRun size * self glyphWidth.
	measuredHeight := self height * aTextRun size isZero not asBit.
	
	self
		assert: [ measuredWidth >= 0 ]
		description: [ 'Width must be positive' ].
		
	self
		assert: [ measuredHeight >= 0 ]
		description: [ 'Height must be positive' ].

	aParagraphSpan applyFixedMetrics: self.
	
	aParagraphSpan textRun: aTextRun
		start: (1 min: aTextRun size)
		end: aTextRun size.
	
	^ aParagraphSpan
]

{ #category : #dispatch }
BlTextParagraphFixedSpanMeasurer >> measureTextParagraph: aBrTextParagraph [
	aBrTextParagraph
		measureOn: self
		with: self
]

{ #category : #metrics }
BlTextParagraphFixedSpanMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : #metrics }
BlTextParagraphFixedSpanMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textOffset [
	^ textOffset
]

{ #category : #accessing }
BlTextParagraphFixedSpanMeasurer >> textOffset: aNumber [
	textOffset := aNumber
]
