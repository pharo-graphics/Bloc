Class {
	#name : 'BlFontObliqueAttribute',
	#superclass : 'BlFontEmphasisAttribute',
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'text style' }
BlFontObliqueAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder slantOblique
]

{ #category : 'accessing' }
BlFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]
