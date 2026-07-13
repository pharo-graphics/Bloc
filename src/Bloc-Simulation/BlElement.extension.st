Extension { #name : #BlElement }

{ #category : #'*Bloc-Simulation' }
BlElement >> eventSimulator [
	^ BlEventSimulator forElement: self
]
