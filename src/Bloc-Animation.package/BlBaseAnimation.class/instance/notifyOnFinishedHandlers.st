action  handling
notifyOnFinishedHandlers
	self onFinished.
	actionHandlers do: [ :each | each actionPerformed ]