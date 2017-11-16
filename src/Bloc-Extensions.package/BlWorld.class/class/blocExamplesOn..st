world menu
blocExamplesOn: aBuilder
	<worldMenu>
	(aBuilder item: #blocExamples)
		parent: #Bloc;
		target: World;
		order: 1;
		action: [ self gtExamplesContained inspect ];
		label: 'Bloc examples'