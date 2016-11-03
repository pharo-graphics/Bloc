*Bloc-Athens
hash
	^ self x hash
		bitXor: (self y hash bitXor: (self sx hash bitXor: (self sy hash bitXor: (self shx hash bitXor: self shy hash))))