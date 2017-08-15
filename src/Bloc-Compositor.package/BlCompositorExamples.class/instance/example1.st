examples
example1
	<gtExample>
	| parent child1 childInside child2 canvas compositor |
	parent := BlElement new
		elevation: (BlRelativeElevation elevation: 0);
		size: 200 @ 200;
		background: (Color blue alpha: 0.2).
	child1 := BlElement new
		elevation: (BlRelativeElevation elevation: 20);
		size: 50 @ 50;
		background: (Color red alpha: 0.9).
	childInside := BlElement new
		elevation: (BlGlobalElevation elevation: 10);
		size: 75 @ 75;
		background: (Color pink alpha: 0.9).
	child2 := BlElement new
		elevation: (BlRelativeElevation elevation: 0);
		size: 100 @ 100;
		background: (Color green alpha: 0.8).
	child1 addChild: childInside.
	
	parent addChildren: { child1. child2 }.
	parent forceLayout.
	
	canvas := MozCanvas checker: parent extent.
	compositor := BlCompositor on: parent.
	compositor drawOnSpartaCanvas: canvas.
	
	^ canvas