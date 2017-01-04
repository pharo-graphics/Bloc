accessing
root: anElement
	self assert: anElement space isNil.
	anElement
		space: self;
		size: self extent.
	root := anElement.
	rootStyler := self defaultRootStyler.