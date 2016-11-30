running
postOn: anInfiniteElement
	"No need to run animations if infinite element is not attached"
	anInfiniteElement isAttached
		ifFalse: [ ^ self ].
	
	"I was already posted during this frame, skip"
	self isPosted
		ifTrue: [ ^ self ].

	anInfiniteElement postOnAnimation: self.
	isPosted := true