Class {
	#name : 'BlFlowLayoutRightToLeft',
	#superclass : 'BlFlowLayoutDirection',
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'testing' }
BlFlowLayoutRightToLeft >> isLeftToRight [
	^ false
]

{ #category : 'testing' }
BlFlowLayoutRightToLeft >> isRightToLeft [
	^ true
]
