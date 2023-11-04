Class {
	#name : #BlLayoutHorizontalFitContentLimitedResizerState,
	#superclass : #BlLayoutHorizontalResizerState,
	#category : 'Bloc-Layout-Resizer'
}

{ #category : #comparing }
BlLayoutHorizontalFitContentLimitedResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutHorizontalFitContentLimitedResizerState
]

{ #category : #comparing }
BlLayoutHorizontalFitContentLimitedResizerState >> hash [
	^ BlLayoutHorizontalFitContentLimitedResizerState hash
]
