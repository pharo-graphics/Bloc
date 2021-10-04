"
I define a backend independent API of a span measurer.

My responsibility is to measure a given span according to provided properties

"
Class {
	#name : #BlTextParagraphSpanMeasurer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'instance creation' }
BlTextParagraphSpanMeasurer >> createParagraphSpan [
	<return: #BlTextParagraphSpan>

	^ BlTextParagraphSpan new measurer: self
]

{ #category : #measurement }
BlTextParagraphSpanMeasurer >> measureSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlTextParagraphSpan>
	
	self subclassResponsibility
]

{ #category : #measurement }
BlTextParagraphSpanMeasurer >> measureSpan: aBlSpan on: aCanvas [
	"Measure a given text span and return paragraph span with computed metrics"
	<return: #BlTextParagraphSpan>
	
	self subclassResponsibility
]
