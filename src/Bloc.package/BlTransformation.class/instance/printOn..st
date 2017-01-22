printing
printOn: aStream
	|array|
	"| sx   shx   x  |
	 | shy  sy    y  | 
	 |  0    0    1  | "
	array := { sx . shx. x. shy. sy. y . 0.0. 0.0. 1.0 } collect: [ :float |
		|rawString|
		rawString := (float round: 3) asString.
		[ rawString size < 5 ] whileTrue: [ rawString := ' ', rawString ].
		rawString ].
	
	aStream nextPutAll: '|'; nextPutAll: (array at: 1); nextPutAll: (array at: 2); nextPutAll: (array at: 3); nextPutAll: '  |'; cr.
	aStream nextPutAll: ' |'; nextPutAll: (array at: 4); nextPutAll: (array at: 5); nextPutAll: (array at: 6); nextPutAll: '  |'; cr.
	aStream nextPutAll: ' |'; nextPutAll: (array at: 7); nextPutAll: (array at: 8); nextPutAll: (array at: 9); nextPutAll: '  |'.