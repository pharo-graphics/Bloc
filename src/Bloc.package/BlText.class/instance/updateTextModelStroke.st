private
updateTextModelStroke
	self stroke paint ifNil:[^ self].
	textModel attributes: {SpBackgroundColorAttribute color: self stroke paint color} from: 1 to: textModel size"