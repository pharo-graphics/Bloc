*Bloc-Extensions
gtInspectorTypesIn: aComposite
	<gtInspectorPresentationOrder: 5>
	^ aComposite fastList
		title: [ 'Types' translated ];
		when: [ self == BlStrokeLineJoin ];
		display: [  { self bevel. self miter. self round } ];
		format: [ :each | each class joinName ]