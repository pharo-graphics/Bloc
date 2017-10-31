world menu
blocExamplesOn: aBuilder
	<worldMenu>
	(aBuilder item: #blocExamples)
		parent: #Bloc;
		target: World;
		order: 1;
		action: [ (GtExampleGroup new examples: ((RPackageOrganizer default packages 
                select: [ :each | (each name beginsWith: 'Bloc') or: [ each name beginsWith: 'Brick' ] ])
                flatCollect: [ :each | each gtExamplesContained ])) inspect
 ];
		label: 'Bloc examples'