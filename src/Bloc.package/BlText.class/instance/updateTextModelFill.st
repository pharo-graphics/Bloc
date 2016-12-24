private
updateTextModelFill
	self fill ifNil:[^ self].
	textModel  attributes: {SpTextForegroundAttribute paint: self fill } from: 1 to: textModel size
		