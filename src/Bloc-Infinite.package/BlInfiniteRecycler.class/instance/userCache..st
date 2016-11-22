accessing - cache
userCache: aUserCache
	"Set user cache to be used with this recycler.
	aUserCache must not be nil"
	self assert: aUserCache isNotNil.
	
	userCache := aUserCache