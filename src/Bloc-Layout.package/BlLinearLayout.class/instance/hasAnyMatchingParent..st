testing
hasAnyMatchingParent: anElement
	"Return true if any of element's children want to match parent among breadth axis, false otherwise.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.

	^ anElement children accountedByLayout anySatisfy: [ :child | (self orientation breadthProperties: child) resizer isMatchParent ]