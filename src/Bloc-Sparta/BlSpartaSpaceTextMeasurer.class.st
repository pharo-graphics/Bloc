"
I calculate text extent using the BlSpartaCanvas provided by a BlSpartaSpaceRenderer.

"
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
BlSpartaSpaceTextMeasurer >> spaceRenderer: aBlSpartaSpaceRenderer [

	spaceRenderer := aBlSpartaSpaceRenderer
]

{ #category : #accessing }
BlSpartaSpaceTextMeasurer >> spartaCanvas [
	^ self spaceRenderer spartaCanvas
]
