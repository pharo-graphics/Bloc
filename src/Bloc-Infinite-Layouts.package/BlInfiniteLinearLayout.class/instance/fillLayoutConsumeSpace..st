layout
fillLayoutConsumeSpace: aResult	
	"Consume the available space if:
		layoutChunk did not request to be ignored
		OR we are laying out scrap children
		OR we are not doing pre-layout"

	^ (aResult ignoreConsumed not or: [
		layoutState hasScrapList or: [ 
			self state isPreLayout not ] ])
		ifTrue: [ 
			layoutState
				availableSpace: layoutState availableSpace - aResult consumedSpace
				in: self.
			"we keep a separate remaining space because availableSpace is important for recycling"
			aResult consumedSpace negated ]
		ifFalse: [ 0 ]