Class {
	#name : #BrFontItalicAttribute,
	#superclass : #BrFontEmphasisAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BrFontItalicAttribute >> emphasisName [
	<return: #String>
	
	^ 'italic'
]

{ #category : #comparing }
BrFontItalicAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BrFontItalicAttribute >> hash [
	^ self class hash
]
