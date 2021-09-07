"
I am a span measurer that assignes a fixed extent to every text character ignoring text attributes.

Useful for testing the paragraph behaviour

"
Class {
	#name : 'BlMockedTextMeasurer',
	#superclass : 'BlHostTextMeasurer',
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
	#category : 'Bloc-Text-Text-Mocked'
}

{ #category : 'accessing' }
BlMockedTextMeasurer >> ascent [
	<return: #Number>

	^ ascent
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> ascent: aNumber [

	self
		assert: [ aNumber <= 0 ]
		description: [ 'Ascent must be negative' ].

	ascent := aNumber
]

{ #category : 'instance creation' }
BlMockedTextMeasurer >> createParagraphSpan [
	^ BlMockedTextParagraphSpan new measurer: self
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> descent [
	<return: #Number>

	^ descent
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> descent: aNumber [
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Descent must be positive' ].
	
	descent := aNumber
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> glyphWidth [
	<return: #Number>

	^ glyphWidth
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> glyphWidth: aNumber [
	glyphWidth := aNumber
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> height [
	^ height
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> height: aNumber [
	height := aNumber
]

{ #category : 'initialization' }
BlMockedTextMeasurer >> initialize [
	super initialize.

	ascent := -11.
	descent := 4.
	height := 13.
	glyphWidth := 5.
	textOffset := 0
]

{ #category : 'dispatch' }
BlMockedTextMeasurer >> measureTextParagraph: aBrTextParagraph [
	aBrTextParagraph measureOn: self
]

{ #category : 'measurement' }
BlMockedTextMeasurer >> measureTextSpan: aBlSpan [
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
	aParagraphSpan textRun: aTextRun.

	^ aParagraphSpan
]

{ #category : 'metrics' }
BlMockedTextMeasurer >> measuredHeight [
	^ measuredHeight
]

{ #category : 'metrics' }
BlMockedTextMeasurer >> measuredWidth [
	^ measuredWidth
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> textOffset [
	^ textOffset
]

{ #category : 'accessing' }
BlMockedTextMeasurer >> textOffset: aNumber [
	textOffset := aNumber
]
