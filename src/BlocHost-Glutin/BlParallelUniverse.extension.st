Extension { #name : 'BlParallelUniverse' }

{ #category : '*BlocHost-Glutin' }
BlParallelUniverse class >> glutin [
	<blocHost>

	^ self forHost: BlGlutinHost
]
