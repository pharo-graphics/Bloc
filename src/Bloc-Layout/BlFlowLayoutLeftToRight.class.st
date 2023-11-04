Class {
	#name : 'BlFlowLayoutLeftToRight',
	#superclass : 'BlFlowLayoutDirection',
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'testing' }
BlFlowLayoutLeftToRight >> isLeftToRight [
	^ true
]

{ #category : 'testing' }
BlFlowLayoutLeftToRight >> isRightToLeft [
	^ false
]
