session management
checkSession
	session == Smalltalk session
		ifFalse: [
			session == Smalltalk session.
			self releaseCache ]