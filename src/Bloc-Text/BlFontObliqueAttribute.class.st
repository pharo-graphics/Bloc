Class {
	#name : #BlFontObliqueAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'text style' }
BlFontObliqueAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [
	aBlTextFontAndStyleBuilder slantOblique
]

{ #category : #accessing }
BlFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]
