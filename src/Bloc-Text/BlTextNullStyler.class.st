Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'hooks - text modifications' }
BlTextNullStyler >> onTextStyled: aTextStyledEvent editor: aTextEditor [

	" A minimal version without whole text updating"
	aTextEditor notifyTextStyled.

]

{ #category : #private }
BlTextNullStyler >> privateStyle: aBlText [
	^ aBlText
]

{ #category : #private }
BlTextNullStyler >> style: aBlText [
	^ aBlText
]
