host - api
destroyHostSpaceFor: aSpace
	"Closes OSWindow window and unrefer it from bloc space"
	
	aSpace hostSpace close.
	aSpace hostSpace: nil