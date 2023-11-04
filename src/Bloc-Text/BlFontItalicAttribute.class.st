Class {
	#name : #BlFontItalicAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'text style' }
BlFontItalicAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder slantItalic
]

{ #category : #accessing }
BlFontItalicAttribute >> emphasisName [
	<return: #String>
	
	^ 'italic'
]
