examples - compositor
elevationTree
	<gtExample>
	| element compositor |
	
	element := self elementWithElevatedChildren.
	compositor := BlCompositor new.
	
	^ compositor buildElevationTree: element