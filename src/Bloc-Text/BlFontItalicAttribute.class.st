Class {
	#name : 'BlFontItalicAttribute',
	#superclass : 'BlFontEmphasisAttribute',
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'text style' }
BlFontItalicAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder slantItalic
]

{ #category : 'accessing' }
BlFontItalicAttribute >> emphasisName [
	<return: #String>
	
	^ 'italic'
]
