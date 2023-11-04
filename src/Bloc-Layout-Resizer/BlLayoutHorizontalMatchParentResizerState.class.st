Class {
	#name : 'BlLayoutHorizontalMatchParentResizerState',
	#superclass : 'BlLayoutHorizontalResizerState',
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'comparing' }
BlLayoutHorizontalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutHorizontalMatchParentResizerState
]

{ #category : 'comparing' }
BlLayoutHorizontalMatchParentResizerState >> hash [
	^ BlLayoutHorizontalMatchParentResizerState hash
]
