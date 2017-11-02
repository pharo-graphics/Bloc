removing
moveColorDownAt: aNumber
	| aColor |
	aNumber = self itemCount
		ifTrue: [ ^ self ].
	aColor := colors removeAt: aNumber.
	colors add: aColor afterIndex: aNumber.
	self notifyItemMoved: aNumber to: aNumber + 1