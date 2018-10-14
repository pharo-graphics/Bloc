Class {
	#name : #BlFontNormalAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlFontNormalAttribute >> emphasisName [
	<return: #String>
	
	^ 'normal'
]

{ #category : #comparing }
BlFontNormalAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlFontNormalAttribute >> hash [
	^ self class hash
]
