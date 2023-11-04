Class {
	#name : #BlLayoutVerticalMatchParentResizerState,
	#superclass : #BlLayoutVerticalResizerState,
	#category : 'Bloc-Layout-Resizer'
}

{ #category : #comparing }
BlLayoutVerticalMatchParentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutVerticalMatchParentResizerState
]

{ #category : #comparing }
BlLayoutVerticalMatchParentResizerState >> hash [
	^ BlLayoutVerticalMatchParentResizerState hash
]
