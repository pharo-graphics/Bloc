Class {
	#name : 'BlFontObliqueAttribute',
	#superclass : 'BlFontEmphasisAttribute',
	#package : 'Bloc',
	#tag : 'Text-Text-Attributes',
	#package : 'Bloc-Text',
	#tag : 'Text-Attributes'
}

{ #category : 'text style' }
BlFontObliqueAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder slantOblique
]

{ #category : 'accessing' }
BlFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]
