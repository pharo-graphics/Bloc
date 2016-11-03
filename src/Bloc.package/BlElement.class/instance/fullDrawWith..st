drawing experimental
fullDrawWith: aDrawer
	(self isVisible and: [ self isInDirtyAreas ])
		ifFalse: [ ^ self ].
	aDrawer fullDrawElement: self.
	self dirty: false