I'm a helper element that transforms its #contentElement in order to exactly #scaleTo:  my size.

!! Example:

[[[
	| content scalable |
	
	content := BlElement new 
		size: 20@20;
		background: Color red.
	
	scalable := BlScalableElement new.
	scalable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	scalable contentElement: content
]]]