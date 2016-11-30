private
flagsDictionary
	| decl |
	decl := self flagsDecl.
	decl isDictionary
		ifFalse: [ decl := decl asDictionary ].
	decl := (decl associations collect: [ :each | each key asLowercase capitalized -> each value ]) asDictionary.
	^ decl