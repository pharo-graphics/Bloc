tests
testRemove
	| expected actual |
	expected := Array new: self max withAll: false.

	1 to: self max do: [ :i | bucket set: i ].
	(1 to: self max) reverseDo: [ :i |
		| mustBe |
		mustBe := Array new: self max withAll: true.
		i to: self max do: [ :j | mustBe at: j put: false ].
		bucket remove: i.
		self assert: self actual equals: mustBe ].

	actual := self actual.
	self assert: actual equals: expected