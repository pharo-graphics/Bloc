Extension { #name : #TKTConfiguration }

{ #category : #'*Bloc-TaskIt' }
TKTConfiguration class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #taskitExecution)
		label: 'Task it execution profile';
		with: [ (aBuilder pickOne: #profileNamed)
				label: 'Exeucting Profile';
				target: self;
				parent: #taskitExecution;
				default: #gtDevelopment;
				order: 1;
				domainValues: (self profiles collect: #key) ]
]
