updating
updateFull
	(self isFinished or: [
		self update or: [
			self continueWhenFinished ] ])
		ifFalse: [ self finish ].
		
	^ self isFinished not