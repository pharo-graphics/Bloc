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
				description: 'Choose which host to be used for opening spaces'.
			(aBuilder pickOne: #preferableSpartaCanvas)
				target: self;
				precondition: [ self environment includesKey: #BlSpartaRenderer ];
				label: 'Preferable Sparta renderering backend' ;
				domainValues: ((self environment at: #BlSpartaRenderer) availableCanvasBuilderClasses collect: [ :aBuilderClass | aBuilderClass label -> aBuilderClass ]);
				description: 'Choose which graphical library should be used to render bloc spaces' ]