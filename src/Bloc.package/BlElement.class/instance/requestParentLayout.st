layout
requestParentLayout
	"Request invalidation of my parent's (if I have one) layout on next space pulse"
	
	"do nothing if I don't have a parent"
	self hasParent
		ifFalse: [ ^ self ].
	
	self parent requestLayout