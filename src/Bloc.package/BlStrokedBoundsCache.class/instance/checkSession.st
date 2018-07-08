session management
checkSession
	session == Smalltalk session
		ifFalse: [
			self releaseCache.
			session := Smalltalk session ]