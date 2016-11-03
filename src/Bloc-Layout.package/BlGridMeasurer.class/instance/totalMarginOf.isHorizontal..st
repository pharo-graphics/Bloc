margin
totalMarginOf: aChildElement isHorizontal: isHorizontal

	^ (self alignedMarginOf: aChildElement isHorizontal: isHorizontal isLeading: true) + (self alignedMarginOf: aChildElement isHorizontal: isHorizontal isLeading: false)