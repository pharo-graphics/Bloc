Trait {
	#name : #TBlDevScripterCompositeStepTarget,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'targets - copying' }
TBlDevScripterCompositeStepTarget >> onSameTargetAsPreviousStep [
	self target: self previousTarget copy
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterCompositeStepTarget >> previousTarget [
	<return: #BlDevScripterEventTarget>
	^ self explicitRequirement
]
