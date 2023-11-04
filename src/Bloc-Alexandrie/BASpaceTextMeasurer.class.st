Class {
	#name : #BASpaceTextMeasurer,
	#superclass : #BATextMeasurer,
	#instVars : [
		'spaceRenderer'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BASpaceTextMeasurer >> canvas [

	^ self spaceRenderer aeCanvas
]

{ #category : #accessing }
BASpaceTextMeasurer >> spaceRenderer [

	^ spaceRenderer
]

{ #category : #accessing }
BASpaceTextMeasurer >> spaceRenderer: aBASpaceRenderer [

	spaceRenderer := aBASpaceRenderer
]
