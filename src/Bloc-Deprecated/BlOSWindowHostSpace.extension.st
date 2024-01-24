Extension { #name : #BlOSWindowHostSpace }

{ #category : #'*Bloc-Deprecated' }
BlOSWindowHostSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlOSWindowHostSpace >> fullscreen [

	self
		deprecated: 'Use isFullscreen instead of current one'
		transformWith: '`@rcv fullscreen' -> '`@rcv isFullscreen'.

	^ self isFullscreen
]

{ #category : #'*Bloc-Deprecated' }
BlOSWindowHostSpace >> resizable [

	self
		deprecated: 'Use isResizable instead of current one'
		transformWith: '`@rcv resizable' -> '`@rcv isResizable'.

	^ self isResizable
]
