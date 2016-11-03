adding
addFirst: aChild
	array := array copyWithFirst: aChild.
	self arrayChanged