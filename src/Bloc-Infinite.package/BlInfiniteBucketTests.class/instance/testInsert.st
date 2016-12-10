tests
testInsert
	| expected actual |
	expected := Array new: self max withAll: true.
	1 to: self max do: [ :i | expected at: i put: (i % 2 = 0) ].

	1 to: self max do: [ :i | bucket insert: (i % 2 ~= 0) at: 1 ].

	actual := self actual.
	self assert: actual equals: expected