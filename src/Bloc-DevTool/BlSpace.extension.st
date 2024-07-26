Extension { #name : #BlSpace }

{ #category : #'*Bloc-DevTool' }
BlSpace >> addHalosListener [

	self root addEventFilter: BlDevHalosEventListener new
]
