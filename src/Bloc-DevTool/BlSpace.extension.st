Extension { #name : #BlSpace }

{ #category : #'*Bloc-DevTool' }
BlSpace >> withHalos [
	self root addEventFilter: BlDevHalosEventListener new
]
