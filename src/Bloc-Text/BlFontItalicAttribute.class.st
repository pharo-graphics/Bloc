Class {
	#name : #BlFontItalicAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'text style' }
BlFontItalicAttribute >> applyOnTextStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder styleItalic
]

{ #category : #accessing }
BlFontItalicAttribute >> emphasisName [
	<return: #String>
	
	^ 'italic'
]
