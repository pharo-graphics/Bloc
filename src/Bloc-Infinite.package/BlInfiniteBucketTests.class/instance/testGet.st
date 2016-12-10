tests
testGet
	| expected actual |
	expected := Array new: self max withAll: false.
	actual := self actual.
	self assert: actual equals: expected