as yet unclassified
on: anOwner named: aSymbol compute: aBlock
	^ self new
		name: aSymbol;
		owner: anOwner;
		computeBlock: aBlock;
		yourself