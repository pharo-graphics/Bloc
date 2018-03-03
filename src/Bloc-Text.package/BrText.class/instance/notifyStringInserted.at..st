text - notifying
notifyStringInserted: aString at: anIndex
	self announcerDo: [ :anAnnouncer | anAnnouncer announce: (BrTextStringInserted string: aString at: anIndex) ]