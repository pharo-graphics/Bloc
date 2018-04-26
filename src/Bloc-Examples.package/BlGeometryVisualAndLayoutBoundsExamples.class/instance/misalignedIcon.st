debugging triangle and text
misalignedIcon
	<gtExample>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement
		geometry: self misalignedTrianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren:
			{anIconElement.
			aLabelElement}.
	^ aContainerElement