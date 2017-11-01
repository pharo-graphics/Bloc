examples - compositor
elevationTree
	<gtExample>
	| element compositor |
	
	element := self elementWithElevatedChildren.
	element forceLayout.

	compositor := BlCompositor new.
	
	^ compositor buildElevationTree: element