driver selection
current
	^ Session == Smalltalk session ifTrue: [ Current ifNil: [Current := self pickHost ]]
		ifFalse: [ 
			Session := Smalltalk session.
			Current := self pickHost
	]
	