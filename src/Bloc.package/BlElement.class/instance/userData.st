accessing
userData
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of a such facility and prefer clean instance variables when it is possible to define them."
	<return: #Dictionary>
	self assert: misc userData isNotNil.
	^ misc userData