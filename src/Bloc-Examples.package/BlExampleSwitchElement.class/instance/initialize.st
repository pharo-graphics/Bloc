initialization
initialize
	super initialize.
	
	activated := false.
	self skin: self defaultSkin.
	self controller: self defaultController