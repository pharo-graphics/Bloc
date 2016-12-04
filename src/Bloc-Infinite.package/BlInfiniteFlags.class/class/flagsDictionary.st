private
flagsDictionary
	| decl |
	decl := self flagsDecl.
	decl isDictionary
		ifFalse: [ decl := decl asDictionary ].
	decl := (decl associations collect: [ :each |
		| key |
		key := self generateFlagName: each key.
		key -> each value ]) asDictionary.
	^ decl