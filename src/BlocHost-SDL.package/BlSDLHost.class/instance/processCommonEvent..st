private - event
processCommonEvent: aMappedEvent

	hostSpaces valuesDo: [ :aHostSpace |
		| aBlocEvent |
		aBlocEvent := self convertEvent: aMappedEvent hostSpace: aHostSpace.
		aHostSpace enqueueEvent: aBlocEvent ]