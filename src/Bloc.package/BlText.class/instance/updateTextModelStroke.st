private
updateTextModelStroke
	self stroke paint ifNil:[^ self].
	textModel attributes: { SpTextBackgroundAttribute paint: self stroke paint } from: 1 to: textModel size