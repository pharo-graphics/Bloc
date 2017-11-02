removing
moveColorUpAt: aNumber
	| aColor |
	aNumber = 1
		ifTrue: [ ^ self ].
	aColor := colors removeAt: aNumber.
	colors add: aColor beforeIndex: aNumber.
	self notifyItemMoved: aNumber to: aNumber - 1