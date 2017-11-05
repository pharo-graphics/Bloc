*Bloc-Extensions
gtInspectorTransformationsIn: composite
	<gtInspectorPresentationOrder: 20>
		
	^ composite tree 
		title: 'Transformations' translated;
		rootsExpanded;
		display: [ self ];
		children: [ :each | (each isKindOf: BlAffineCompositeTransformation)
				ifTrue: [ each transformations ]
				ifFalse: [ {  } ] ]