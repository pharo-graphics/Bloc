Class {
	#name : 'BlLayoutVerticalFitContentLimitedResizerState',
	#superclass : 'BlLayoutVerticalResizerState',
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutVerticalFitContentLimitedResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutVerticalFitContentLimitedResizerState
]

{ #category : 'comparing' }
BlLayoutVerticalFitContentLimitedResizerState >> hash [
	^ BlLayoutVerticalFitContentLimitedResizerState hash
]
