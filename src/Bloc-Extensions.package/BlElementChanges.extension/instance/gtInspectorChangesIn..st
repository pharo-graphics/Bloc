*Bloc-Extensions
gtInspectorChangesIn: composite
	<gtInspectorPresentationOrder: 90>
		
	composite tree 
		title: 'Changes' translated;
		rootsExpanded;
		display: [ self changes select: [ :each | each loggedValues isNotEmpty ] ];
		children: [ :each | (each isKindOf: BlElementChange)
				ifTrue: [ each loggedValues ]
				ifFalse: [ {  } ] ]