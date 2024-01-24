Extension { #name : #BlMorphicWindowHostSpace }

{ #category : #'*Bloc-Deprecated' }
BlMorphicWindowHostSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlMorphicWindowHostSpace >> fullsize [

	self
		deprecated: 'Use isFullsize instead of current one'
		transformWith: '`@rcv fullsize' -> '`@rcv isFullsize'.
		
	^ self isFullsize
]
