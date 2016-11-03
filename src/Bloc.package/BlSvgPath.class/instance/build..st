instance creation
build: aBlock
	| b |
	b := ASPathConverter new.
	aBlock value: b.
	self pathData: b convertPathData