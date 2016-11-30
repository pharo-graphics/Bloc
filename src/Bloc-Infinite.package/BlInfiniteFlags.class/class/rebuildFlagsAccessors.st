private
rebuildFlagsAccessors
	self flagsDictionary keysDo: [ :each | 
		self defineFlagAccesorFor: each.
		self defineFlagTestAccesorFor: each.
		self defineFlagClearAccesorFor: each.
		self defineFlagAddAccesorFor: each ]