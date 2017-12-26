accessing
controller: aController
	self removeEventHandler: self controller.
	controller := aController.
	self addEventHandler: self controller