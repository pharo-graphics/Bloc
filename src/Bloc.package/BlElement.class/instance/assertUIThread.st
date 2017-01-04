asserting
assertUIThread
	self
		assert: [ self isAttachedToSceneGraph
			ifTrue: [ BlUniverse default pulseLoop loopProcess == Processor activeProcess ]
			ifFalse: [ true ] ]
		description: [ 'Must be sent only from UI thread' ]