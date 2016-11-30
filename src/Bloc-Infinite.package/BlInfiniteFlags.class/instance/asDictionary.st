converting
asDictionary

	^ (self class classPool associations
		collect: [ :each | each key -> (self hasNamed: each key) ])
			asDictionary