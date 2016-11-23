initialize-release
initialize
	super initialize.
	
	holder := self defaultHolder.
	decorationInsets := BlInsets all: 0.
	pendingInvalidate := false