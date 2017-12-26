accessing
callbackOrNil
	(method hasPragmaNamed: #callback:)
		ifFalse: [ ^ nil ].
	
	^ method methodClass classAndMethodFor: ((method pragmaAt: #callback:) argumentAt: 1)
		do: [ :aClass :aMethod | aMethod ]
		ifAbsent: [ nil ]