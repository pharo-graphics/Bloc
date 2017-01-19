private - event
processWindowEvent: aGdkEvent
	| aHostSpace |

	aHostSpace := hostSpaces
		at: aGdkEvent windowID
		ifAbsent: [ "window with unknown id, ignore it" ^ self ].

	self
		convertEvent: aGdkEvent
		hostSpace: aHostSpace.
