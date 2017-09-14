instance creation
build: aBlock
	| b |
	b := BlSvgPathConverter new.
	aBlock value: b.
	self pathData: b convertPathData