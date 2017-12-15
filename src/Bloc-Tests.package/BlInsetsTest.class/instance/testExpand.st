tests
testExpand
	| insets rectangle |
	insets := BlInsets all: 10.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets expand: rectangle) = (-10 @ -10 corner: 110 @ 110)