Class {
	#name : #BlLayoutVerticalFitContentResizerState,
	#superclass : #BlLayoutVerticalResizerState,
	#category : 'Bloc-Layout-Resizer'
}

{ #category : #comparing }
BlLayoutVerticalFitContentResizerState >> = anotherState [
	^ anotherState isKindOf: BlLayoutVerticalFitContentResizerState
]

{ #category : #comparing }
BlLayoutVerticalFitContentResizerState >> hash [
	^ BlLayoutVerticalFitContentResizerState hash
]
