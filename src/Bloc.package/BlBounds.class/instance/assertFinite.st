debug - asserting
assertFinite
	self
		assert: [ left < Float infinity and: [ left > Float negativeInfinity ] ]
		description: [ 'Left must not be infinity' ].
	
	self
		assert: [ right < Float infinity and: [ right > Float negativeInfinity ] ]
		description: [ 'Right must not be infinity' ].

	self
		assert: [ top < Float infinity and: [ top > Float negativeInfinity ] ]
		description: [ 'Top must not be infinity' ].

	self
		assert: [ bottom < Float infinity and: [ bottom > Float negativeInfinity ] ]
		description: [ 'Bottom must not be infinity' ].