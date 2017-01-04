private - event
processWindowEvent: aMappedEvent
	| aBlocEvent aHostSpace |

	aHostSpace := hostSpaces
		at: aMappedEvent windowID
		ifAbsent: [ "window with unknown id, ignore it" ^ self ].

	aBlocEvent := self
		convertEvent: aMappedEvent
		hostSpace: aHostSpace.

	aHostSpace enqueueEvent: aBlocEvent