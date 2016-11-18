recycling
removeScrap
	"Remove all scrap elements out of this recycler.
	Detached elements contained within a recycler pool will remain"

	attachedScrap removeAll.
	self recycleAndRemoveCachedElements