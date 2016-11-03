private
updateTextModelFill
	self fill ifNil:[^ self].
	textModel  attributes: {SpForegroundColorAttribute color: self fill color } from: 1 to: textModel size
		