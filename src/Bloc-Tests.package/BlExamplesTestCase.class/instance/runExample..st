tests
runExample: example
	" this is not the testing tool we have in mind, but a temporary solution to integrate examples into the currently existing testing tools "
	| exampleResult |
	exampleResult := super runExample: example.
	(exampleResult returnValue isKindOf: BlElement) ifFalse: [ ^ self ].
	self testInSpace: exampleResult returnValue.
	^ exampleResult