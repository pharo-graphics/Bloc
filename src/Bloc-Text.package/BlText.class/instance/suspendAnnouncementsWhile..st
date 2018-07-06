text - notifying
suspendAnnouncementsWhile: aBlock
	announcer
		ifNil: aBlock
		ifNotNil: [ :anAnnouncer | anAnnouncer suspendAllWhile: aBlock ]