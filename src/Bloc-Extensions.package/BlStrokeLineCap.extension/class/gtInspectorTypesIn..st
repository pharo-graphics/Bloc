*Bloc-Extensions
gtInspectorTypesIn: aComposite
	<gtInspectorPresentationOrder: 5>
	^ aComposite fastList
		title: [ 'Types' translated ];
		when: [ self == BlStrokeLineCap ];
		display: [ { self butt. self round. self square } ];
		format: [ :each | each class capName ]