initialization
initialize
	super initialize.
	
	borderListener := BlEventHandler
		on: BlElementBorderChangedEvent
		do: [ :anEvent | self handleWidthChanged: anEvent currentTarget border width ]