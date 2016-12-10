layout
layoutChunkMeasureVertical: anElement result: aResult
	<return: #Rectangle>
	| aLeft aTop aRight aBottom |
	
	self isLayoutRTL
		ifTrue: [ 
			aRight := self width - self paddingRight.
			aLeft := aRight - (self orientation decoratedMeasurementInOther: anElement) ]
		ifFalse: [ 
			aLeft := self paddingLeft.
			aRight := aLeft + (self orientation decoratedMeasurementInOther: anElement) ].
	
	layoutState isLayoutStartDirection
		ifTrue: [ 
			aBottom := layoutState offset.
			aTop := aBottom - aResult consumedSpace ]
		ifFalse: [ 
			aTop := layoutState offset.
			aBottom := aTop + aResult consumedSpace ].

	^ (aLeft @ aTop) corner: (aRight @ aBottom)