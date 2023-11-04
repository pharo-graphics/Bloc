Class {
	#name : 'BATextElementMockedMeasurer',
	#superclass : 'BlTextElementMeasurer',
	#instVars : [
		'measurer'
	],
	#package : 'Bloc',
	#tag : 'Alexandrie-Text-Mocked',
	#package : 'Bloc-Alexandrie',
	#tag : 'Text-Mocked'
}

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> ascent [
	^ measurer ascent
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> ascent: aNumber [
	measurer ascent: aNumber
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> descent [
	^ measurer descent
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> descent: aNumber [
	measurer descent: aNumber
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> glyphHeight [
	^ measurer height
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> glyphHeight: aNumber [
	measurer height: aNumber
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> glyphWidth [
	^ measurer glyphWidth
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> glyphWidth: aNumber [
	measurer glyphWidth: aNumber
]

{ #category : 'initialization' }
BATextElementMockedMeasurer >> initialize [

	super initialize.

	measurer := BAMockedTextMeasurer new.
	measurer ascent: -10.
	measurer descent: 5.
	measurer glyphWidth: 10.
	measurer height: 15
]

{ #category : 'initialization' }
BATextElementMockedMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	measurer measureTextParagraph: aBlTextParagraph
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> textOffset [
	^ measurer textOffset
]

{ #category : 'font - metrics' }
BATextElementMockedMeasurer >> textOffset: aNumber [
	measurer textOffset: aNumber
]
