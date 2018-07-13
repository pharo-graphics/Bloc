text - notifying
notifyDeleted: aFromIndex to: aToIndex
	self announcerDo: [ :anAnnouncer | anAnnouncer announce: (BlTextDeleted from: aFromIndex to: aToIndex) ]