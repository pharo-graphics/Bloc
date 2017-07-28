builder
build
	<return: #BlBackground>
	self
		assert: [ backgrounds isNotEmpty ]
		description: [ 'There should be specified at least one background' ].
	
	^ backgrounds size > 1
		ifTrue: [ BlCompositeBackground withAll: backgrounds ]
		ifFalse: [ backgrounds first ]