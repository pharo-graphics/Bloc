Extension { #name : #BlHeadlessHostSpace }

{ #category : #'*Bloc-Deprecated' }
BlHeadlessHostSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlHeadlessHostSpace >> fullscreen [

	self
		deprecated: 'Use isFullscreen instead of current one'
		transformWith: '`@rcv fullscreen' -> '`@rcv isFullscreen'.

	^ self isFullscreen
]

{ #category : #'*Bloc-Deprecated' }
BlHeadlessHostSpace >> fullsize [

	self
		deprecated: 'Use isFullsize instead of current one'
		transformWith: '`@rcv fullsize' -> '`@rcv isFullsize'.
		
	^ self isFullsize
]

{ #category : #'*Bloc-Deprecated' }
BlHeadlessHostSpace >> resizable [

	self
		deprecated: 'Use isResizable instead of current one'
		transformWith: '`@rcv resizable' -> '`@rcv isResizable'.

	^ self isResizable
]
