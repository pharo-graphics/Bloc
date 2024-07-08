"
I represent a homogeneous styled piece of text where every character has the same set of attributes.
I am data structure independent and rely only on `BlText`'s public API

"
Class {
	#name : #BlSpan,
	#superclass : #BlReadonlyText,
	#instVars : [
		'attributes'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlSpan class >> text: aBlText attributes: theAttributes [

	^ self basicNew
		initialize;
		text: aBlText attributes: theAttributes;
		yourself
]

{ #category : #'span - accessing' }
BlSpan >> attributes [
	"Return a collection of attributes that apply on this span"

	^ attributes
]

{ #category : #'text - attributes' }
BlSpan >> attributesFinder [
	^ BlTextAttributesExplicitFinder new
		initializeForAttributes: attributes
		interval: ((1 min: self size) to: self size)
]

{ #category : #testing }
BlSpan >> isTabulation [

	text ifEmpty: [ ^ false ].
	^ text first == Character tab
]

{ #category : #initialization }
BlSpan >> text: aBlText attributes: theAttributes [

	text := aBlText.
	attributes := theAttributes
]
