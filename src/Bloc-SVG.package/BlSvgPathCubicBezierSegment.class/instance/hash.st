comparing
hash
	^ ((self isAbsolute hash bitXor: self curveTo hash) bitXor: self firstViaPoint hash) bitXor: self secondViaPoint hash