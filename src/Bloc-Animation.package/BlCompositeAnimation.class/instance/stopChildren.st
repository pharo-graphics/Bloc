pulse
stopChildren
	animations
		select: [ :anAnimation | anAnimation isRunning ]
		thenDo: [ :anAnimation | anAnimation stop ]