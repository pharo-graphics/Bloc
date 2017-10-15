transformations
scaleTo: aVector
	"Replace all existing scaling transformation with a single one
	that takes place of the very first scaling transformation.
	For example, existing transformation list (L1)
		- translate
		- scale X1
		- rotate
		- scale X2
	will be transformed into the following:
		- translate
		- scale Y
		- rotate
	note, how two existing scaling transformation got merged into one"
	
	