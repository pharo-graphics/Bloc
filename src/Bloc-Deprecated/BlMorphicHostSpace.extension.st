Extension { #name : #BlMorphicHostSpace }

{ #category : #'*Bloc-Deprecated' }
BlMorphicHostSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlMorphicHostSpace >> fullsize [

	self
		deprecated: 'Use isFullsize instead of current one'
		transformWith: '`@rcv fullsize' -> '`@rcv isFullsize'.
		
	^ self isFullsize
]
