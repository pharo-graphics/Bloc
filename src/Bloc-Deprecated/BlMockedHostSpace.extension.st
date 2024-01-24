Extension { #name : #BlMockedHostSpace }

{ #category : #'*Bloc-Deprecated' }
BlMockedHostSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlMockedHostSpace >> fullscreen [

	self
		deprecated: 'Use isFullscreen instead of current one'
		transformWith: '`@rcv fullscreen' -> '`@rcv isFullscreen'.

	^ self isFullscreen
]

{ #category : #'*Bloc-Deprecated' }
BlMockedHostSpace >> fullsize [

	self
		deprecated: 'Use isFullsize instead of current one'
		transformWith: '`@rcv fullsize' -> '`@rcv isFullsize'.
		
	^ self isFullsize
]
