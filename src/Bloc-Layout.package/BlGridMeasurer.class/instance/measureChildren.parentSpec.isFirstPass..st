measure
measureChildren: anElement parentSpec: anExtentSpec isFirstPass: isFirstPass

	anElement children accountedByLayout
		select: [ :child | child visibility shouldMeasure ]
		thenDo: [ :child | isFirstPass
			ifTrue: [ self naiveMeasureChild: child parentSpec: anExtentSpec ]
			ifFalse: [ self improvedMeasureChild: child parentSpec: anExtentSpec ] ]