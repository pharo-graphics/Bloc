Trait {
	#name : 'TBlDevScripterCompositeStepTarget',
	#category : 'Bloc-Scripter-Scripter',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter'
}

{ #category : 'targets - copying' }
TBlDevScripterCompositeStepTarget >> onSameTargetAsPreviousStep [
	self target: self previousTarget copy
]

{ #category : 'targets - accessing and updating' }
TBlDevScripterCompositeStepTarget >> previousTarget [
	<return: #BlDevScripterEventTarget>
	^ self explicitRequirement
]
