private - event
processCommonEvent: aGdkEvent

	hostSpaces valuesDo: [ :aHostSpace | 
		| aBlocEvent |
		aBlocEvent := self convertEvent: aGdkEvent hostSpace: aHostSpace.
		aHostSpace enqueueEvent: aBlocEvent ]