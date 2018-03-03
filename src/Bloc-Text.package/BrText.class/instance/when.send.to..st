text - notifying
when: anAnnouncementClass send: aSelector to: anObject
	self ensureAnnouncer.
	announcer weak when: anAnnouncementClass send: aSelector to: anObject