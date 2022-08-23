Class {
	#name : #BlTextNullStyler,
	#superclass : #BlTextStyler,
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'hooks - text modifications' }
BlTextNullStyler >> onTextStyled: aTextStyledEvent editor: aTextEditor [

	" A minimal version without whole text updating"

	(aTextStyledEvent text isNextGenerationOf: aTextEditor text)
		ifTrue: [ 
			aTextEditor text rope: aTextStyledEvent text text rope.
			aTextStyledEvent afterAction value: aTextEditor text.
			aTextEditor notifyTextStyled.
			"to be revised: processing "
			aTextEditor processCursorAttributes.
			self flag: 'Try to no ask for global update by default because it speed-up text editing a lot'.
			"aTextEditor updater	all; update" ]
]

{ #category : #private }
BlTextNullStyler >> privateStyle: aBlText [
	^ aBlText
]

{ #category : #private }
BlTextNullStyler >> style: aBlText [
	^ aBlText
]
