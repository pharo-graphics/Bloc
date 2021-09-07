Class {
	#name : 'BlFontNormalAttribute',
	#superclass : 'BlFontEmphasisAttribute',
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'text style' }
BlFontNormalAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder slantNormal
]

{ #category : 'accessing' }
BlFontNormalAttribute >> emphasisName [
	<return: #String>
	
	^ 'normal'
]
