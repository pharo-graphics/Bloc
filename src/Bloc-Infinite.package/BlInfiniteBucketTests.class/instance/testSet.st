tests
testSet
	| expected actual |
	expected := Array new: self max withAll: false.
	1 to: self max do: [ :i | expected at: i put: (i % 2 = 0) ].
	
	1 to: self max do: [ :i | (i % 2 = 0) ifTrue: [ bucket set: i ] ].

	actual := self actual.
	self assert: actual equals: expected