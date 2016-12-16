children add/remove
removeFromParent
	"Remove me from parent if I have one"

	self hasParent
		ifFalse: [ ^ self ].

	self parent removeChild: self