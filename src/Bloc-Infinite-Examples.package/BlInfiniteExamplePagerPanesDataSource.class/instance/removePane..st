accessing
removePane: aPagerPane
	| paneIndex |
	
	paneIndex := panes
		indexOf: aPagerPane
		ifAbsent: [ ^ self ].
	
	panes removeAt: paneIndex.
	self notifyItemsRemoved: (paneIndex to: paneIndex)