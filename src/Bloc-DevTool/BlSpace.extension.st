Extension { #name : #BlSpace }

{ #category : #'*Bloc-DevTool' }
BlSpace >> addHalosListener [

	self root addEventFilter: BlDevHalosEventListener new
]

{ #category : #'*Bloc-DevTool' }
BlSpace >> withHalos [

	self
		deprecated: 'Please use #addHalosListener'
		transformWith: '`@receiver withHalos' -> '`@receiver addHalosListener'.

	self addHalosListener
]
