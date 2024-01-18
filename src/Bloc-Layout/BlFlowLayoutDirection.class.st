Class {
	#name : #BlFlowLayoutDirection,
	#superclass : #Object,
	#category : #'Bloc-Layout-Flow-Utilities'
}

{ #category : #testing }
BlFlowLayoutDirection >> isLeftToRight [
	^ self subclassResponsibility
]

{ #category : #testing }
BlFlowLayoutDirection >> isRightToLeft [
	^ self subclassResponsibility
]
