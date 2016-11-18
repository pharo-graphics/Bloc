accessing - properties
cacheSize: aRequestedCacheSize
	"Request change of the maximum number of detached, valid elements we should retain for later use.
	It is not guaranteed that new cache size will be equal to requested one!"

	requestedCacheSize = aRequestedCacheSize.
	self updateCacheSize