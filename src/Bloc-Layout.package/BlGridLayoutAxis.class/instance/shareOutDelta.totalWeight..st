computing deltas
shareOutDelta: totalDelta totalWeight: totalWeight
	| mTotalDelta mTotalWeight |
	mTotalDelta := totalDelta.
	mTotalWeight := totalWeight.
	
	deltas atAllPut: 0.
	
	self element managedChildren withIndexDo: [ :child :index |
		child visibility shouldLayout ifTrue: [ 
			| spec weight |
			spec := self specOf: child.
			weight := spec weight asFloat.
			weight ~= 0 ifTrue: [ 
				| delta |
				delta := (weight / mTotalWeight * mTotalDelta) rounded.
				deltas at: index put: delta.
				mTotalDelta := mTotalDelta - delta.
				mTotalWeight := mTotalWeight - weight ] ] ]