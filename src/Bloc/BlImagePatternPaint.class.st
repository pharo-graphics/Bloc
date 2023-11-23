Class {
	#name : #BlImagePatternPaint,
	#superclass : #BlPaint,
	#instVars : [
		'form'
	],
	#category : #'Bloc-Paint'
}

{ #category : #'as yet unclassified' }
BlImagePatternPaint class >> form: aForm [
	^ self new form: aForm
]

{ #category : #accessing }
BlImagePatternPaint >> form [
	^ form
]

{ #category : #accessing }
BlImagePatternPaint >> form: aForm [
	form := aForm
]

{ #category : #geometry }
BlImagePatternPaint >> matchExtent: anExtent [
	"don't know what to do for the image pattern paint"
]
