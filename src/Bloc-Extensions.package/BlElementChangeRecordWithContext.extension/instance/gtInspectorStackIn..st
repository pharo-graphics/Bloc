*Bloc-Extensions
gtInspectorStackIn: aComposite
	<gtInspectorPresentationOrder: 0>
	^ aComposite fastTable
		title: 'Stack';
		display: [ self context stack ];
		column: 'Class' evaluated: [:each | each methodClass ];
		column: 'Method' evaluated: [:each | each selector]