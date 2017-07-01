tests
testIfExact
	| isExact |
	
	isExact := false.
	resizer ifExact: [ :aResizer | isExact := aResizer == resizer ].
	
	self assert: isExact