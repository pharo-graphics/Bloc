Class {
	#name : #BlFlowLayoutRightToLeft,
	#superclass : #BlFlowLayoutDirection,
	#category : #'Bloc-Layout-Flow-Utilities'
}

{ #category : #testing }
BlFlowLayoutRightToLeft >> isLeftToRight [
	^ false
]

{ #category : #testing }
BlFlowLayoutRightToLeft >> isRightToLeft [
	^ true
]
