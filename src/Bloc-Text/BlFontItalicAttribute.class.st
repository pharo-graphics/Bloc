Class {
	#name : #BlFontItalicAttribute,
	#superclass : #BlFontEmphasisAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlFontItalicAttribute >> emphasisName [
	<return: #String>
	
	^ 'italic'
]

{ #category : #comparing }
BlFontItalicAttribute >> equals: aTextAttribute [
	^ true
]

{ #category : #comparing }
BlFontItalicAttribute >> hash [
	^ self class hash
]
