initialization
initialize
	super initialize.
	
	"keys := SortedCollection sortBlock: [ :keyA :keyB | keyA keyValue < keyB keyValue ]".
	combinations := OrderedCollection new