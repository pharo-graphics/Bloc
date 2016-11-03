layout
requestParentLayout
	| p |
	p := self parent.
	p ifNotNil: [ p requestLayout ]