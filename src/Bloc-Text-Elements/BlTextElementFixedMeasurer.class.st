Class {
	#name : #BlTextElementFixedMeasurer,
	#superclass : #BlTextElementMeasurer,
	#instVars : [
		'measurer'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> ascent [
	^ measurer ascent
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> ascent: aNumber [
	measurer ascent: aNumber
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> descent [
	^ measurer descent
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> descent: aNumber [
	measurer descent: aNumber
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> glyphHeight [
	^ measurer height
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> glyphHeight: aNumber [
	measurer height: aNumber
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> glyphWidth [
	^ measurer glyphWidth
]

{ #category : #'font - metrics' }
BlTextElementFixedMeasurer >> glyphWidth: aNumber [
	measurer glyphWidth: aNumber
]

{ #category : #initialization }
BlTextElementFixedMeasurer >> initialize [
	super initialize.
	
	measurer := BrTextParagraphFixedSpanMeasurer new.
	measurer ascent: 10.
	measurer descent: 5.
	measurer glyphWidth: 10.
	measurer height: 15
]

{ #category : #initialization }
BlTextElementFixedMeasurer >> measurer [
	^ measurer
]
