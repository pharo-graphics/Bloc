initialization
initialize
	super initialize.
	
	borderListener := BlEventHandler
		on: BlElementBorderChangedEvent
		do: [ :anEvent | self onWidthChanged: anEvent currentTarget border width ]