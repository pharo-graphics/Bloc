layout
layoutChunkMeasureHorizontal: anElement result: aResult
	<return: #Rectangle>
	| aLeft aTop aRight aBottom |
	
	aTop := self paddingTop.
	aBottom := aTop + (self orientation decoratedMeasurementInOther: anElement).
	
	layoutState isLayoutStartDirection
		ifTrue: [ 
			aRight := layoutState offset.
			aLeft := layoutState offset - aResult consumedSpace ]
		ifFalse: [
			aLeft := layoutState offset.
			aRight := layoutState offset + aResult consumedSpace].

	^ (aLeft @ aTop) corner: (aRight @ aBottom)
		
	