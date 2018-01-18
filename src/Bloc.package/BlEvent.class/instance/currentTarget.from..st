private - accessing
currentTarget: aTBlEventTarget	from: aDispatcher
	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Target must not be nil' ].
	
	currentTarget = aTBlEventTarget
		ifTrue: [ ^ self ].

	currentTarget := aTBlEventTarget.
	self traversedTargets add: currentTarget -> aDispatcher