events
wantsEvent: anEvent
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]