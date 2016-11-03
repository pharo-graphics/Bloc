removing
removeAll: anArray
	array := array copyWithoutAll: anArray.
	self arrayChanged