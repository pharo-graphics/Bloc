Class {
	#name : 'BlLayoutVerticalMatchParentResizerState',
	#superclass : 'BlLayoutVerticalResizerState',
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutVerticalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutVerticalMatchParentResizerState
]

{ #category : 'comparing' }
BlLayoutVerticalMatchParentResizerState >> hash [
	^ BlLayoutVerticalMatchParentResizerState hash
]
