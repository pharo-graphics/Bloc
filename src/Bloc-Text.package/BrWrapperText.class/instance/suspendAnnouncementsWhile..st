text - notifying
suspendAnnouncementsWhile: aBlock
	super suspendAnnouncementsWhile: [
		self text suspendAnnouncementsWhile: aBlock ]