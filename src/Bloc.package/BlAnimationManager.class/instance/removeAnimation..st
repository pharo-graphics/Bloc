add/remove
removeAnimation: anAnim
	animations remove: anAnim.
	BlUniverse default requestNextPulse.