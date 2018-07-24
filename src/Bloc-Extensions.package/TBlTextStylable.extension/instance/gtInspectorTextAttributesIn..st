*Bloc-Extensions
gtInspectorTextAttributesIn: aComposite
	<gtInspectorPresentationOrder: 0>

	^ aComposite fastList
		title: 'Text attributes' translated;
		display: [ self textProperties attributes ];
		when: [ self respondsTo: #attributes ]