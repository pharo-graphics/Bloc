Extension { #name : #BlSpace }

{ #category : #'*Bloc-Deprecated' }
BlSpace >> aeAsForm [

	self
		deprecated: 'Send #aeAsForm to my root instead'
		transformWith: '`@rcv aeAsForm' -> '`@rcv root aeAsForm'.
	
	^ self root aeAsForm
]

{ #category : #'*Bloc-Deprecated' }
BlSpace >> borderless [

	self
		deprecated: 'Use isBorderless instead of current one'
		transformWith: '`@rcv borderless' -> '`@rcv isBorderless'.

	^ self isBorderless
]

{ #category : #'*Bloc-Deprecated' }
BlSpace >> fullscreen [

	self
		deprecated: 'Use isFullscreen instead of current one'
		transformWith: '`@rcv fullscreen' -> '`@rcv isFullscreen'.

	^ self isFullscreen
]

{ #category : #'*Bloc-Deprecated' }
BlSpace >> fullsize [

	self
		deprecated: 'Use isFullsize instead of current one'
		transformWith: '`@rcv fullsize' -> '`@rcv isFullsize'.
		
	^ self isFullsize
]

{ #category : #'*Bloc-Deprecated' }
BlSpace >> resizable [

	self
		deprecated: 'Use isResizable instead of current one'
		transformWith: '`@rcv resizable' -> '`@rcv isResizable'.

	^ self isResizable
]
