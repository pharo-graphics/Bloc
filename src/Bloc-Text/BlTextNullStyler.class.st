Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #private }
BlTextNullStyler >> privateStyle: aText [
	^ aText
]

{ #category : #private }
BlTextNullStyler >> style: aBrText [
]

{ #category : #private }
BlTextNullStyler >> style: aBrText afterDo: aBlock [
	aBlock value
]
