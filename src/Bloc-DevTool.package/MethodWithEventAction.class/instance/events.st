accessing
events
	(method hasPragmaNamed: #event:)
		ifFalse: [ ^ #() ].
	
	^ (method pragmas select: [ :aPragma | aPragma keyword = #event: ])
		flatCollect: [ :aPragma |
			self class environment
				at: (aPragma argumentAt: 1)
				ifPresent: [ :aClass | { aClass } ]
				ifAbsent: [ #() ] ]