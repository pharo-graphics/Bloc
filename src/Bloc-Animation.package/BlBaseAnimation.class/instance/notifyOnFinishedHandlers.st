private - notifying
notifyOnFinishedHandlers
	self onFinished.
	actionHandlers do: [ :each | each actionPerformed ]