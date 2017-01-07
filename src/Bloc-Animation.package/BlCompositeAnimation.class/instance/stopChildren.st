pulse
stopChildren
	children
		select: [ :anAnimation | anAnimation isRunning ]
		thenDo: [ :anAnimation | anAnimation stop ]