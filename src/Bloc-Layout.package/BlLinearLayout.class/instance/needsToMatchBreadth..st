testing
needsToMatchBreadth: anElement
	"Return true if anElement wants to match breadth of parent during improved measurement pass, false otherwise.
	During naive measurement we assume that we have a simple case when parent already knows its breadth (breadth mode is exact).
	In simple case so we can match breadth of children instantly without need of second pass.
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ self orientation breadthMode isExact not and: [ (self orientation breadthProperties: anElement) resizer isMatchParent ]