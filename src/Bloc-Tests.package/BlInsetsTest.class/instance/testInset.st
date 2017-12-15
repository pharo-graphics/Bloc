tests
testInset
	| insets rectangle |
	insets := BlInsets all: 10.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets inset: rectangle) = (10 @ 10 corner: 90 @ 90)