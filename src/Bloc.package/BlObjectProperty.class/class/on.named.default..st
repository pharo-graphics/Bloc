instance creation
on: anOwner named: aSymbol default: aValue
	^ self new
		name: aSymbol;
		owner: anOwner;
		rawValue: aValue;
		yourself