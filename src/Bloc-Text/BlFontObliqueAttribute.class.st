Class {
	#name : #BlFontObliqueAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'text style' }
BlFontObliqueAttribute >> applyOnTextStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder styleOblique
]

{ #category : #accessing }
BlFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]
