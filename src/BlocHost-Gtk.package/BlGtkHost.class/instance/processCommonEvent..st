private - event
processCommonEvent: aGdkEvent
	hostSpaces valuesDo: [ :aHostSpace | 
		self convertEvent: aGdkEvent hostSpace: aHostSpace ]