instance creation
on: anOwner named: aSymbol default: aValue invalidated: anInvalidatedBlock when: aWhenBlock
	^ self new
		name: aSymbol;
		owner: anOwner;
		rawValue: aValue;
		invalidated: anInvalidatedBlock;
		when: aWhenBlock;
		yourself