Class {
	#name : #BrFontEmphasisAttribute,
	#superclass : #BrTextAttribute,
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrFontEmphasisAttribute class >> italic [
	^ BrFontItalicAttribute new
]

{ #category : #'instance creation' }
BrFontEmphasisAttribute class >> normal [
	^ BrFontNormalAttribute new
]

{ #category : #'instance creation' }
BrFontEmphasisAttribute class >> oblique [
	^ BrFontObliqueAttribute new
]

{ #category : #accessing }
BrFontEmphasisAttribute >> emphasisName [
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #printing }
BrFontEmphasisAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-style: ';
		nextPutAll: self emphasisName
]
