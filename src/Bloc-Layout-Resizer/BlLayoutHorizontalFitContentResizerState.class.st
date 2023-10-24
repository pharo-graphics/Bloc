Class {
	#name : 'BlLayoutHorizontalFitContentResizerState',
	#superclass : 'BlLayoutHorizontalResizerState',
	#category : 'Bloc-Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutHorizontalFitContentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutHorizontalFitContentResizerState
]

{ #category : 'comparing' }
BlLayoutHorizontalFitContentResizerState >> hash [
	^ BlLayoutHorizontalFitContentResizerState hash
]
