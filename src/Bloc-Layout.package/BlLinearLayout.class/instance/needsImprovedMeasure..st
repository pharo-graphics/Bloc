testing
needsImprovedMeasure: anElement
	"Return true if children of anElement need second measuring pass, false otherwise.
	Improved measure is often needed if any of children wants to match parent or we
	skipped some elements during naive measurement pass
	anElement must not be nil"
	<return: #Boolean>
	self assert: anElement isNotNil.
	
	^ (self hasSkippedNaiveMeasurements: anElement) or: [ self cache length ~= self cache totalLength and: [ self cache totalWeight > 0 ] ]