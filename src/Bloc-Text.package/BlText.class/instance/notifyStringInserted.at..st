text - notifying
notifyStringInserted: aString at: anIndex
	self announcerDo: [ :anAnnouncer | anAnnouncer announce: (BlTextStringInserted string: aString at: anIndex) ]