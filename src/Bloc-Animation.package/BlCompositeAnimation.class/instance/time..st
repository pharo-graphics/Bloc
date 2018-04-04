accessing
time: aBlTime
	super time: aBlTime.
	
	self animations do: [ :anAnimation | anAnimation time: aBlTime ]