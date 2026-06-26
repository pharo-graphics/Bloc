Extension { #name : #BlElement }

{ #category : #'*Bloc-Simulation' }
BlElement >> simulator [
	^ BlEventSimulator forElement: self
]
