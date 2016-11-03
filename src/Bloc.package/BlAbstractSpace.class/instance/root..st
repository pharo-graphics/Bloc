accessing
root: anElement
	self assert: anElement space isNil.
	anElement
		space: self;
		extent: self extent.
	root := anElement.
	rootStyler := self defaultRootStyler.