Class {
	#name : #BlLayoutHorizontalMatchParentResizerState,
	#superclass : #BlLayoutHorizontalResizerState,
	#category : 'Bloc-Layout-Resizer'
}

{ #category : #comparing }
BlLayoutHorizontalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutHorizontalMatchParentResizerState
]

{ #category : #comparing }
BlLayoutHorizontalMatchParentResizerState >> hash [
	^ BlLayoutHorizontalMatchParentResizerState hash
]
