Class {
	#name : #BlTextElementWithFixedMeasurer,
	#superclass : #BlTextElement,
	#instVars : [
		'measurer'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> ascent [
	^ measurer ascent
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> ascent: aNumber [
	measurer ascent: aNumber
]

{ #category : #initialization }
BlTextElementWithFixedMeasurer >> defaultTextMeasurer [
	^ measurer
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> descent [
	^ measurer descent
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> descent: aNumber [
	measurer descent: aNumber
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> glyphHeight [
	^ measurer height
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> glyphHeight: aNumber [
	measurer height: aNumber
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> glyphWidth [
	^ measurer glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementWithFixedMeasurer >> glyphWidth: aNumber [
	measurer glyphWidth: aNumber
]

{ #category : #initialization }
BlTextElementWithFixedMeasurer >> initialize [
	super initialize.
	
	measurer := BrTextParagraphFixedSpanMeasurer new.
	measurer ascent: 10.
	measurer descent: 5.
	measurer glyphWidth: 10.
	measurer height: 15
]
