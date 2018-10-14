Class {
	#name : #BlFontObliqueAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]

{ #category : #comparing }
BlFontObliqueAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlFontObliqueAttribute >> hash [
	^ self class hash
]
