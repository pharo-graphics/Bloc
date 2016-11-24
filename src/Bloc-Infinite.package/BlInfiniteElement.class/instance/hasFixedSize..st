accessing - properties
hasFixedSize: aBoolean
	"InfiniteElement can perform several optimizations if it can know in advance that InfiniteElement's
	size is not affected by the datasource contents. InfiniteElement can still change its size based
	on other factors (e.g. its parent's size) but this size calculation cannot depend on the
	size of its children or contents of its datasource (except the number of items in the datasource).
	If your use of InfiniteElement falls into this category, set this to true. It will allow
	InfiniteElement to avoid invalidating the whole layout when its datasource contents change"

	hasFixedSize := aBoolean