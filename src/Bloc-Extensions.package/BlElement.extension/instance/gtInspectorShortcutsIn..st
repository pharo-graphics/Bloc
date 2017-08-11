*Bloc-Extensions
gtInspectorShortcutsIn: composite
	<gtInspectorPresentationOrder: 90>  
	composite table 
		title: 'Shortcuts' translated;
		display: [ self shortcuts ];
		column: 'Key' evaluated: [ :each | each combination gtDisplayString ];
		column: 'Action' evaluated: [ :each | each action asString ];
		when: [ self shortcuts notEmpty ]