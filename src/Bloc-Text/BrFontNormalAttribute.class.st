Class {
	#name : #BrFontNormalAttribute,
	#superclass : #BrFontEmphasisAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrFontNormalAttribute >> emphasisName [
	<return: #String>
	
	^ 'normal'
]

{ #category : #comparing }
BrFontNormalAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrFontNormalAttribute >> hash [
	^ self class hash
]
