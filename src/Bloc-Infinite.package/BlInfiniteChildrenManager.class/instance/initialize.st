initialization
initialize
	super initialize.
	
	bucket := self defaultBucket.
	hiddenChildren := OrderedCollection new