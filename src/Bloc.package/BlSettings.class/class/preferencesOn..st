settings
preferencesOn: aBuilder
	<systemsettings>
	(aBuilder group: #Bloc)
		label: 'Bloc';
		description: 'Bloc settings';
		parent: self preferencesGroup;
		with: [
			(aBuilder pickOne: #preferableHostClass)
				target: self;
				label: 'Preferable host' ;
				domainValues: (BlHost availableHostClasses collect: [ :aHostClass | aHostClass label -> aHostClass ]);
				description: 'Choose which host to be used for opening spaces' ]