host space - events
fetchedEventsDo: aBlock
	"Flush event queue and evaluate a given block with every queued event as argument"

	self eventFetcher fetchedEventsDo: aBlock