initialization
initialize
	super initialize.
	
	changedScrap := OrderedCollection new.
	attachedScrap := OrderedCollection new.
	cachedScrap := OrderedCollection new.
	fetcher := self defaultFetcher