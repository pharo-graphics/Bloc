examples
cell
	<gtExample>
	
	^ BlElement new
		size: 50 @ 30;
		background: Color random muchLighter darker;
		addEventHandlerOn: BlFocusEvent do: [ :anEvent | anEvent target border: (BlBorder paint: Color blue width: 2) ];
		addEventHandlerOn: BlBlurEvent do: [ :anEvent | anEvent target border: BlBorder empty ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | anEvent target requestFocus ]