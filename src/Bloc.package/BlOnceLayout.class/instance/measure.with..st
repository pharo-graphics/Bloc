measure
measure: anElement with: anExtentSpec
	self isStopped
		ifTrue: [ ^ super measure: anElement with: anExtentSpec ].
	self layout measure: anElement with: anExtentSpec