measure
measureChildren: anElement parentSpec: anExtentSpec isFirstPass: isFirstPass

	anElement managedChildren
		select: [ :child | child visibility shouldMeasure ]
		thenDo: [ :child | isFirstPass
			ifTrue: [ self naiveMeasureChild: child parentSpec: anExtentSpec ]
			ifFalse: [
				child visibility shouldMeasure ifTrue: [
					self improvedMeasureChild: child parentSpec: anExtentSpec ] ] ]