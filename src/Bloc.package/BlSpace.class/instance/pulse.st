pulse
pulse
	[ self processPulse ]
		on: Error
		do: [ :anError |
			anError freeze.
			[ anError debug ] fork.
			self dispatchEvent: (BlSpaceErrorEvent on: anError) ]