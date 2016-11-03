as yet unclassified
on: anOwner named: aSymbol delegateTo: aProperty do: aDelegationBlock
	^ self new
		name: aSymbol;
		owner: anOwner;
		delegateTo: aProperty;
		do: aDelegationBlock;
		yourself