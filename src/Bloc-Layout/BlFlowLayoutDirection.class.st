Class {
	#name : #BlFlowLayoutDirection,
	#superclass : #Object,
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #testing }
BlFlowLayoutDirection >> isLeftToRight [
	^ self subclassResponsibility
]

{ #category : #testing }
BlFlowLayoutDirection >> isRightToLeft [
	^ self subclassResponsibility
]
