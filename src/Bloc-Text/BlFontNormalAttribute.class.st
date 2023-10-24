Class {
	#name : 'BlFontNormalAttribute',
	#superclass : 'BlFontEmphasisAttribute',
	#category : 'Bloc-Text-Text-Attributes',
	#package : 'Bloc-Text',
	#tag : 'Text-Attributes'
}

{ #category : 'text style' }
BlFontNormalAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder slantNormal
]

{ #category : 'accessing' }
BlFontNormalAttribute >> emphasisName [
	<return: #String>
	
	^ 'normal'
]
