actions
browseEvents
	| theEvents |
	
	theEvents := self events.
	
	theEvents ifEmpty: [ ^ self ].

	theEvents size = 1
		ifTrue: [ ^ theEvents first browse ].

	Smalltalk tools browser
		openOnGroup: (NautilusClassGroup named: 'Events' classes: theEvents) beReadOnly
		inEnvironment: (RBClassEnvironment classes: theEvents)