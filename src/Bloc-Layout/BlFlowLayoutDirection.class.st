Class {
	#name : 'BlFlowLayoutDirection',
	#superclass : 'Object',
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'testing' }
BlFlowLayoutDirection >> isLeftToRight [
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlFlowLayoutDirection >> isRightToLeft [
	^ self subclassResponsibility
]
