initialization
initialize
	super initialize.
	fill := self defaultFill. 
	stroke := self defaultStroke.
	wrappingWidth := 0.
	textModel := SpText fromString:''.
	wrapAttribute := SpTextWrapAttribute new none.
	textModel attributes: { wrapAttribute } from: 1 to: textModel size.
	