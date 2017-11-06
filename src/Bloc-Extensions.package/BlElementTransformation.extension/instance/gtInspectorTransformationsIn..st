*Bloc-Extensions
gtInspectorTransformationsIn: composite
		
	^ composite tree 
		title: 'Transformations' translated;
		rootsExpanded;
		display: [ self ];
		children: [ :each | {} ]