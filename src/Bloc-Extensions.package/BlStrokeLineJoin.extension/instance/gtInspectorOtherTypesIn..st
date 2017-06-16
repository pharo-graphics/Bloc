*Bloc-Extensions
gtInspectorOtherTypesIn: aComposite
	<gtInspectorPresentationOrder: 6>
	
	^ (self class gtInspectorTypesIn: aComposite)
		title: [ 'Other types' translated ];
		when: [ self class ~= BlStrokeLineJoin ]