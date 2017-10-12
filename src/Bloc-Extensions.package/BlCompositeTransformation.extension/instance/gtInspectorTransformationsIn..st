*Bloc-Extensions
gtInspectorTransformationsIn: composite
	<gtInspectorPresentationOrder: 20>
		
	composite tree 
		title: 'Transformations' translated;
		rootsExpanded;
		display: [ self ];
		children: [ :each | (each isKindOf: BlCompositeTransformation)
				ifTrue: [ each transformations ]
				ifFalse: [ {  } ] ]