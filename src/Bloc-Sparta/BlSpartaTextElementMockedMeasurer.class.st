Class {
	#name : #BlSpartaTextElementMockedMeasurer,
	#superclass : #BlTextElementMeasurer,
	#instVars : [
		'measurer'
	],
	#category : #'Bloc-Sparta-Mocked'
}

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> ascent [
	^ measurer ascent
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> ascent: aNumber [
	measurer ascent: aNumber
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> descent [
	^ measurer descent
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> descent: aNumber [
	measurer descent: aNumber
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> glyphHeight [
	^ measurer height
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> glyphHeight: aNumber [
	measurer height: aNumber
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> glyphWidth [
	^ measurer glyphWidth
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> glyphWidth: aNumber [
	measurer glyphWidth: aNumber
]

{ #category : #initialization }
BlSpartaTextElementMockedMeasurer >> initialize [
	super initialize.
	
	measurer := BlSpartaMockedTextMeasurer new.
	measurer ascent: -10.
	measurer descent: 5.
	measurer glyphWidth: 10.
	measurer height: 15
]

{ #category : #initialization }
BlSpartaTextElementMockedMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [
	measurer measureTextParagraph: aBlTextParagraph
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> textOffset [
	^ measurer textOffset
]

{ #category : #'font - metrics' }
BlSpartaTextElementMockedMeasurer >> textOffset: aNumber [
	measurer textOffset: aNumber
]
