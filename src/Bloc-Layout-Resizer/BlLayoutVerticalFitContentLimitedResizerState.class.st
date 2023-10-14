Class {
	#name : 'BlLayoutVerticalFitContentLimitedResizerState',
	#superclass : 'BlLayoutVerticalResizerState',
	#category : 'Bloc-Layout-Resizer',
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
