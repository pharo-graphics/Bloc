"
I am a span measurer that assignes a fixed extent to every text character ignoring text attributes.

Useful for testing the paragraph behaviour

"
Class {
	#name : #BlSpartaMockedTextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'ascent',
		'descent',
		'glyphWidth',
		'height',
		'measuredWidth',
		'measuredHeight',
		'textOffset'
	],
	#category : #'Bloc-Sparta-Mocked'
}

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> ascent: aNumber [

	self
		assert: [ aNumber <= 0 ]
		description: [ 'Ascent must be negative' ].

	ascent := aNumber
]

{ #category : #'instance creation' }
BlSpartaMockedTextMeasurer >> createParagraphSpan [
	^ BlMockedTextParagraphSpan new measurer: self
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> descent: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Descent must be positive' ].
	
	descent := aNumber
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> height [
	^ height
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : #initialization }
BlSpartaMockedTextMeasurer >> initialize [
	super initialize.

	ascent := -11.
	descent := 4.
	height := 13.
	glyphWidth := 5.
	textOffset := 0
]

{ #category : #measurement }
BlSpartaMockedTextMeasurer >> measureTextParagraph: aBlTextParagraph [

	aBlTextParagraph measureOn: self
]

{ #category : #measurement }
BlSpartaMockedTextMeasurer >> measureTextSpan: aBlSpan [
	<return: #BlSpartaTextParagraphSpan>
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
	aParagraphSpan textRun: aTextRun.

	^ aParagraphSpan
]

{ #category : #metrics }
BlSpartaMockedTextMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : #metrics }
BlSpartaMockedTextMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> textOffset [
	^ textOffset
]

{ #category : #accessing }
BlSpartaMockedTextMeasurer >> textOffset: aNumber [
	textOffset := aNumber
]
