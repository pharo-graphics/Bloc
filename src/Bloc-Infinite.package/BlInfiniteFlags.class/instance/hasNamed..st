testing
hasNamed: aFlagName
	^ value & (self class classPool
		at: aFlagName
		ifAbsent: [ self error: 'Unknown flag: ', aFlagName asString ]) ~= 0