private - notifying
notifyRun: isFinished
	self dispatchEvent: (BlOvershootingScrollerRunEvent new isFinished: isFinished)