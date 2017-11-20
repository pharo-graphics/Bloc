*Bloc-Extensions
gtInspectorMetricsIn: aComposite
	<gtInspectorPresentationOrder: 2>

	aComposite fastTable 
		title: 'Metrics' translated;
		display: [ self metrics associations collect: [ :anAssiciation | ('   ', anAssiciation key) -> anAssiciation value ] ];
		column: 'Metric' evaluated: [ :each | each key ] width: 100;
		column: 'Value' evaluated: [ :each | each value gtDisplayString ];
		selectionTransformation: #value