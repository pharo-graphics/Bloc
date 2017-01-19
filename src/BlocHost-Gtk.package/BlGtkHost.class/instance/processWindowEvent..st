private - event
processWindowEvent: aGdkEvent
	| aBlocEvent aHostSpace |

	aHostSpace := hostSpaces
		at: aGdkEvent windowID
		ifAbsent: [ "window with unknown id, ignore it" ^ self ].

	aBlocEvent := self
		convertEvent: aGdkEvent
		hostSpace: aHostSpace.

	aHostSpace enqueueEvent: aBlocEvent