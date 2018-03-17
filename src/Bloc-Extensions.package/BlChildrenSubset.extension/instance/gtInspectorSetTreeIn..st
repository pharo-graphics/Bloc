*Bloc-Extensions
gtInspectorSetTreeIn: aComposite
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite tree 
		title: 'Tree' translated;
		allExpanded;
		display: [ { self } ];
		children: [ :each | each hasSuperset ifTrue: [ { each superset } ] ifFalse: [ #() ] ];
		when: [ self hasSuperset ]