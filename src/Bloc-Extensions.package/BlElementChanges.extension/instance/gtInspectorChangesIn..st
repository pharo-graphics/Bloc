*Bloc-Extensions
gtInspectorChangesIn: composite
	<gtInspectorPresentationOrder: 90>
		
	composite tree 
		title: 'Changes' translated;
		rootsExpanded;
		display: [ self changes select: [ :each | each records isNotEmpty ] ];
		children: [ :each | (each isKindOf: BlElementChange)
				ifTrue: [ each records ]
				ifFalse: [ {  } ] ]