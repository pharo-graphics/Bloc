initialization
defaultRootStyler
	^ self class environment
		at: #BrRootStyler
		ifPresent: [ :aStylerClass | aStylerClass on: self root ]
		ifAbsent: [ BlNullStyler new ]