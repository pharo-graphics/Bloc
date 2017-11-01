examples - elevation
elementWithElevatedChildren
	<gtExample>
	| parent child1 childInside child2 |
	
	parent := self elementWithZeroRelativeElevation
		size: 200 @ 200;
		relocate: 20@0;
		background: (Color blue alpha: 0.2).

	child1 := self elementWithRelativeElevation20
		size: 50 @ 50;
		relocate: 0@10;
		background: (Color red alpha: 0.9).
	
	childInside := self elementWithGlobalElevation10
		size: 75 @ 75;
		background: (Color pink alpha: 0.9).
	
	child2 := self elementWithZeroRelativeElevation
		size: 100 @ 100;
		background: (Color green alpha: 0.8).

	child1 addChild: childInside.
	
	parent addChildren: { child1. child2 }.
	
	^ parent