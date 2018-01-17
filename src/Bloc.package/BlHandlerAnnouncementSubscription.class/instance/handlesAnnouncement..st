testing
handlesAnnouncement: anAnnouncement
	<return: #Boolean>

	^ self subscriber wantsEvent: anAnnouncement