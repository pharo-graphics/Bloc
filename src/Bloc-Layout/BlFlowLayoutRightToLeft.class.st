Class {
	#name : #BlFlowLayoutRightToLeft,
	#superclass : #BlFlowLayoutDirection,
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #testing }
BlFlowLayoutRightToLeft >> isLeftToRight [
	^ false
]

{ #category : #testing }
BlFlowLayoutRightToLeft >> isRightToLeft [
	^ true
]
