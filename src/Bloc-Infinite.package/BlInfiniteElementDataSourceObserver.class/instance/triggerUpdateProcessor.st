private
triggerUpdateProcessor
	(infiniteElement hasFixedSize and: [ infiniteElement isAttached ])
		ifTrue: [ infiniteElement postChildrenUpdater ]
		ifFalse: [
			infiniteElement markDataSourceChangeDuringMeasure.
			infiniteElement requestLayout ]