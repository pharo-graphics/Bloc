dispatching
dispatchScrollStateChanged: aScrollState

	"Let the Layout go first; this allows it to bring any properties into
	a consistent state before the InfiniteElement subclass responds"
	self layout onScrollStateChanged: aScrollState.
	
	"Let the InfiniteElement subclass handle this event next;
	any Layout property changes will be reflected by this time."
	self onScrollStateChanged: aScrollState.
	
	"Event handlers go last. All other internal state is consistent by this point"
	self notifyScrollStateChanged: aScrollState