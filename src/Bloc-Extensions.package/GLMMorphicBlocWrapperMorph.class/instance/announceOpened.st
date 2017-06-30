announcements
announceOpened
	super announceOpened.
	
	self window announcer when: WindowClosed send: #onWindowClosed to: self