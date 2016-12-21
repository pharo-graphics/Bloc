layout
fillLayoutResultScroll: aResult
	
	layoutState hasScrollingOffset
		ifFalse: [ ^ self ].

	layoutState scrollingOffset: layoutState scrollingOffset + aResult consumedSpace.
	layoutState availableSpace < 0
		ifTrue: [ layoutState scrollingOffset: layoutState scrollingOffset + layoutState availableSpace ].
	
	self recycleChildren