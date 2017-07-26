tests
testProcessKeyDown
	| eventA |

	eventA := BlKeyDownEvent new.
	eventA key: Key a.

	processor processKeyDown: eventA.
	self assert: (processor buffer hasEvent: Key a)