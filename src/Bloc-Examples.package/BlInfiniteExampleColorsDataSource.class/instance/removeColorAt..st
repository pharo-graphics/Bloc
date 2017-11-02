removing
removeColorAt: aNumber
	colors removeAt: aNumber.
	self notifyItemsRemoved: (aNumber to: aNumber)