Class {
	#name : 'BlLayoutHorizontalFitContentLimitedResizerState',
	#superclass : 'BlLayoutHorizontalResizerState',
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutHorizontalFitContentLimitedResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutHorizontalFitContentLimitedResizerState
]

{ #category : 'comparing' }
BlLayoutHorizontalFitContentLimitedResizerState >> hash [
	^ BlLayoutHorizontalFitContentLimitedResizerState hash
]
