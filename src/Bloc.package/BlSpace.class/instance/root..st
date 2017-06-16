accessing
root: anElement
	"Make a given element my root element.
	anElement must not be nil.
	anElement must not be added to any scene graph"
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'anElement must not be nil' ].

	self
		assert: [ anElement space isNil ]
		description: [ 'New root must not be already have a space assigned!' ].

	anElement
		space: self;
		size: self extent.

	root := anElement.
	"Root styler is created for the root element. Since we change root element
	we must also recreate a styler"
	rootStyler := self defaultRootStyler