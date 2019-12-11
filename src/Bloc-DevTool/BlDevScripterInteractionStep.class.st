Class {
	#name : #BlDevScripterInteractionStep,
	#superclass : #BlDevScripterTargetedStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]
