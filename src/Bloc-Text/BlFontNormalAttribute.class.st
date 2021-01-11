Class {
	#name : #BlFontNormalAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'text style' }
BlFontNormalAttribute >> applyOnTextStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder styleNormal
]

{ #category : #accessing }
BlFontNormalAttribute >> emphasisName [
	<return: #String>
	
	^ 'normal'
]
