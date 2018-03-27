tests
testProcessKeyDown
	| eventA |

	eventA := BlKeyDownEvent new.
	eventA key: KeyboardKey a.

	processor processKeyDown: eventA.
	self assert: (processor buffer hasEvent: KeyboardKey a)