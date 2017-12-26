public
activated: aBoolean
	aBoolean
		ifTrue: [ self activate ]
		ifFalse: [ self deactivate ]