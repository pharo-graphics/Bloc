*Bloc-Extensions
gtInspectorChangesIn: composite
	<gtInspectorPresentationOrder: 90>  
	composite fastTable 
		title: 'Changes' translated;
		display: [ changeMap values ];
		column: 'Name' evaluated: [ :each | each name ];
		column: 'Old value' evaluated: [ :each | each oldValue gtDisplayString ];
		column: 'New value' evaluated: [ :each | each newValue gtDisplayString ];
		when: [ changeMap notEmpty ]