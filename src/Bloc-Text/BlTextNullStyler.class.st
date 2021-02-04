Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #styling }
BlTextNullStyler >> fireStyledEventForText: aStyledText andAfterAction: aBlock [
	"do nothing"
]

{ #category : #private }
BlTextNullStyler >> privateStyle: aText [
	^ aText
]

{ #category : #private }
BlTextNullStyler >> style: aBrText [
	^ aBrText
]
