children accessing
childAt: anIndex
	"Returns the child at anIndex"
	<return: #BlElement>
	| anOffset |
	
	anOffset := self computeOffset: anIndex.
	self
		assert: [ anOffset >= 0 ]
		description: [ 'Index must be positive!' ].

	^ controller childAt: anOffset