comparing
hash
	^ ((self class hash bitXor: self start hash) bitXor: self end hash) bitXor: self text hash