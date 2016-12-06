recycling
recycleAndRemoveCachedElements
	"Recycle and remove all cached elements"
	
	"iterate in reversed order since we delete cached elements from collection by index"
	cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		self recycleCachedAt: anIndex ].
	
	"post-condition to make sure recycling worked well"
	self
		assert: [ cachedScrap isEmpty ]
		description: [ 'Cached scrap collection must be empty after recycling of all element!' ]