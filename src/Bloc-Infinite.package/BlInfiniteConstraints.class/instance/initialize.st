initialize-release
initialize
	super initialize.
	
	holder := self defaultHolder.
	pendingInvalidate := false