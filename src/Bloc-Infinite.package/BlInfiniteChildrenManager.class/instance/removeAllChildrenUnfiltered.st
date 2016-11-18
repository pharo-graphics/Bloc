children add/remove
removeAllChildrenUnfiltered
	"Remove all children from the infinite element including the hidden ones"

	bucket reset.
	
	hiddenChildren copy reverseWithIndexDo: [ :child :index |
		controller onLeftHiddenState: child.
		hiddenChildren removeAt: index ].

	controller removeAllChildren