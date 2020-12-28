Class {
	#name : #BlSpartaSpaceTextMeasurer,
	#superclass : #BlSpartaTextMeasurer,
	#category : #'Bloc-Sparta-Text'
}

{ #category : #accessing }
BlSpartaSpaceTextMeasurer >> spaceRenderer [
	^ spaceRenderer
]

{ #category : #accessing }
BlSpartaSpaceTextMeasurer >> spaceRenderer: anObject [
	spaceRenderer := anObject
]

{ #category : #accessing }
BlSpartaSpaceTextMeasurer >> spartaCanvas [
	^ self spaceRenderer spartaCanvas
]
