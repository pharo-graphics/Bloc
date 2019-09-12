Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #styling }
BlTextNullStyler >> onlyFireStyledEventForText: aStyledText andAfterAction: aBlock [
	"do nothing"
]

{ #category : #private }
BlTextNullStyler >> onlyStyle: aBrText [
	^ aBrText
]

{ #category : #private }
BlTextNullStyler >> privateStyle: aText [
	^ aText
]
