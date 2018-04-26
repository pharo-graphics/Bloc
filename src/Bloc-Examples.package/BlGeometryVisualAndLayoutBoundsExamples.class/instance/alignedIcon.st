debugging triangle and text
alignedIcon
	<gtExample>
	| anIconElement aLabelElement aContainerElement |
	anIconElement := self emptyIconElement
		geometry: self trianglePolygon.
	aLabelElement := self textElementWithRunText.
	aContainerElement := self iconAndTextContainer.
	aContainerElement
		addChildren:
			{anIconElement.
			aLabelElement}.
	^ aContainerElement