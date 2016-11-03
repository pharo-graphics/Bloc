accessing
clientUpdated
	self relocate: self client txBounds origin - (5@5).
	self extent: self client txBounds extent + (10@10).
	self updateActionsPosition.