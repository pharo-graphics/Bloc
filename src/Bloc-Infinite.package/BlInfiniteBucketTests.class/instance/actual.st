initialization
actual
	^ (1 to: self max) collect: [ :i | bucket get: i ]