*Bloc-Extensions
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 0>

	^ composite fastList
		title: 'Children';
		display: [ self asArray ];
		format: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ]