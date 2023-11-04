Class {
	#name : 'BlLayoutVerticalFitContentResizerState',
	#superclass : 'BlLayoutVerticalResizerState',
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutVerticalFitContentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutVerticalFitContentResizerState
]

{ #category : 'comparing' }
BlLayoutVerticalFitContentResizerState >> hash [
	^ BlLayoutVerticalFitContentResizerState hash
]
