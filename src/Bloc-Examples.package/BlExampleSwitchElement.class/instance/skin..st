accessing
skin: aSkin
	self removeEventHandler: self skin.
	
	skin := aSkin.
	self addEventHandler: self skin