tests
testMatches
	<gtExample>
	self setUp.

	shortcut combination: (BlMockedKeyCombination new shouldMatch: false).
	self assert: (shortcut matches: Object new) not.
	
	shortcut combination: (BlMockedKeyCombination new shouldMatch: true).
	self assert: (shortcut matches: Object new).

	self tearDown