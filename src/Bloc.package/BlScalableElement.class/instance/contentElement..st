accessing
contentElement: anElement
	"Specify an element that should be scaled according to my size.
	If I already have a content element, it will be replaced with a new one.
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Content element must not be nil' ].

	"If we already have a content element, we should remove an old one
	in order to replace it with one just provided"
	self hasContentElement
		ifTrue: [ self removeChild: self contentElement ].

	contentElement := anElement.
	self addChild: contentElement