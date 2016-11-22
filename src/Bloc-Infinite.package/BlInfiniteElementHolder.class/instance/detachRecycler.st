private
detachRecycler
	"Detaches recycler setting it to nil and isInChangeScrap to false.
	Additionally set returned from scrap flag to false"
	recycler := nil.
	isInChangeScrap := false.
	self flagReturnedFromScrap: false