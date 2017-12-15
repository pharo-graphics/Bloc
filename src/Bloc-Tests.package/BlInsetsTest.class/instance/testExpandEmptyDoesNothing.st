tests
testExpandEmptyDoesNothing
	| insets rectangle |
	insets := BlInsets empty.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets expand: rectangle) = rectangle.
	self assert: (insets expand: rectangle) == rectangle.