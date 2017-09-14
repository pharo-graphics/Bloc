accessing
factory
	factory ifNil: [ factory:= self factoryByDefault ].
	^ factory