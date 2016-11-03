change reporting
checkSession
	session == Smalltalk session ifFalse: [ 
		session := Smalltalk session.
		self hostWindow: nil.
		self show.
		self root dirty: true.
		self beDirtyArea.
		self requestNextPulse
		 ]