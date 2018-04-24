comparing
hash
	^ (self isAbsolute hash bitXor: self curveTo hash) bitXor: self viaPoint hash