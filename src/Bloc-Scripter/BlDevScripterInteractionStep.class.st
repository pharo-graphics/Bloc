Class {
	#name : 'BlDevScripterInteractionStep',
	#superclass : 'BlDevScripterTargetedStep',
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'initialization' }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]
