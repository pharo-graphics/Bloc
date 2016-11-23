testing
isElementInvalid
	"Returns true if the element I am attached to is now representing potentially invalid data.
	An InfiniteLayout should scrap/recycle it."
	<return: #Boolean>
	
	^ holder isInvalid