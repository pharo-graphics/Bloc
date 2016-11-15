children add/remove
removeAllChildrenUnfiltered

	bucket reset.
	
	hiddenChildren copy reverseWithIndexDo: [ :child :index |
		controller onLeftHiddenState: child.
		hiddenChildren removeAt: index ].

	controller removeAllChildren