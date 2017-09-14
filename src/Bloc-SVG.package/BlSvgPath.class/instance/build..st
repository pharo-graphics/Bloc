instance creation
build: aBlock
	| aPathbuilder |
	aPathbuilder := BlSvgPathBuilder new.
	aBlock value: aPathbuilder.
	self pathData: aPathbuilder convertedPathData