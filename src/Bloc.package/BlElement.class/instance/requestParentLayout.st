layout
requestParentLayout
	self parent
		ifNotNil: [ :anElement | anElement requestLayout ]