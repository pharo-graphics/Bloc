Class {
	#name : #BrFontObliqueAttribute,
	#superclass : #BrFontEmphasisAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrFontObliqueAttribute >> emphasisName [
	<return: #String>
	
	^ 'oblique'
]

{ #category : #comparing }
BrFontObliqueAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrFontObliqueAttribute >> hash [
	^ self class hash
]
