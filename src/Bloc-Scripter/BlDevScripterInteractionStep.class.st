Class {
	#name : 'BlDevScripterInteractionStep',
	#superclass : 'BlDevScripterTargetedStep',
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : 'initialization' }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]
