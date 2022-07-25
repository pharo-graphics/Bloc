Class {
	#name : #BlTextElementMockedMeasurer,
	#superclass : #BlTextElementMeasurer,
	#instVars : [
		'measurer'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> ascent [
	^ measurer ascent
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> ascent: aNumber [
	measurer ascent: aNumber
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> descent [
	^ measurer descent
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> descent: aNumber [
	measurer descent: aNumber
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> glyphHeight [
	^ measurer height
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> glyphHeight: aNumber [
	measurer height: aNumber
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> glyphWidth [
	^ measurer glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> glyphWidth: aNumber [
	measurer glyphWidth: aNumber
]

{ #category : #initialization }
BlTextElementMockedMeasurer >> initialize [
	super initialize.
	
	measurer := BlSpartaMockedTextMeasurer new.
	measurer ascent: -10.
	measurer descent: 5.
	measurer glyphWidth: 10.
	measurer height: 15
]

{ #category : #initialization }
BlTextElementMockedMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [
	measurer measureTextParagraph: aBlTextParagraph
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> textOffset [
	^ measurer textOffset
]

{ #category : #'font - metrics' }
BlTextElementMockedMeasurer >> textOffset: aNumber [
	measurer textOffset: aNumber
]
