scrolling
smoothScrollToPosition: aPosition
	"Starts a smooth scroll to a datasource position."
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
	self layout smoothScrollToPosition: aPosition