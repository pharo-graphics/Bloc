world menu
resetUniverseOn: aBuilder
	<worldMenu>
	(aBuilder item: #resetUniverse)
		parent: #Bloc;
		target: World;
		order: 10;
		action: [ BlUniverse reset ];
		label: 'Reset Bloc Universe'