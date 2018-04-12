instance creation
cell
	<gtExample>
	
	^ BlElement new
		size: 75@75;
		background: Color random paler;
		addEventHandlerOn: BlElementSelectionAcquiredEvent
			do: [ :anEvent | anEvent target border: (BlBorder builder width: 2; paint: Color blue; build)  ];
		addEventHandlerOn: BlElementSelectionLostEvent
			do: [ :anEvent | anEvent target border: BlBorder empty ]