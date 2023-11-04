Class {
	#name : 'BASpaceTextMeasurer',
	#superclass : 'BATextMeasurer',
	#instVars : [
		'spaceRenderer'
	],
	#package : 'Bloc',
	#tag : 'Alexandrie-Text',
	#package : 'Bloc-Alexandrie',
	#tag : 'Text'
}

{ #category : 'accessing' }
BASpaceTextMeasurer >> canvas [

	^ self spaceRenderer aeCanvas
]

{ #category : 'accessing' }
BASpaceTextMeasurer >> spaceRenderer [

	^ spaceRenderer
]

{ #category : 'accessing' }
BASpaceTextMeasurer >> spaceRenderer: aBASpaceRenderer [

	spaceRenderer := aBASpaceRenderer
]
