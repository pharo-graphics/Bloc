initialization
initialize
	super initialize.
	fill := self defaultFill. 
	stroke := self defaultStroke.
	wrappingWidth := 0.
	textModel := SpText fromString:''.
	layoutView := SpartaTextLayout new.
	wrapAttribute := SpTextWrapAttribute new wordWrap.
	textModel attributes: { wrapAttribute } from: 1 to: textModel size.
	