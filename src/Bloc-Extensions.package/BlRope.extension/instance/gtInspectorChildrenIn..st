*Bloc-Extensions
gtInspectorChildrenIn: composite
	<gtInspectorPresentationOrder: 10>
	composite table
		title: 'Children';
		display: [ { self } ];
		children: [ :each | each children ];
		column: 'Class' evaluated: [ :each | each class name ];
		column: 'Description' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each ]