comparing
hash
	^ ((((self sx hash bitXor: self shy hash)
		bitXor: self shx hash)
			bitXor: self sy hash)
				bitXor: self x hash)
					bitXor: self y hash