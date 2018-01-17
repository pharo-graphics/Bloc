announcing
deliver: anAnnouncement

	(self handlesAnnouncement: anAnnouncement)
		ifTrue: [ self subscriber handleEvent: anAnnouncement ]