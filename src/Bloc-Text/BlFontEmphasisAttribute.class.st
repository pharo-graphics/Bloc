Class {
	#name : 'BlFontEmphasisAttribute',
	#superclass : 'BlTextAttribute',
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'instance creation' }
BlFontEmphasisAttribute class >> italic [
	^ BlFontItalicAttribute new
]

{ #category : 'instance creation' }
BlFontEmphasisAttribute class >> normal [
	^ BlFontNormalAttribute new
]

{ #category : 'instance creation' }
BlFontEmphasisAttribute class >> oblique [
	^ BlFontObliqueAttribute new
]

{ #category : 'accessing' }
BlFontEmphasisAttribute >> emphasisName [
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : 'printing' }
BlFontEmphasisAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-style: ';
		nextPutAll: self emphasisName
]
