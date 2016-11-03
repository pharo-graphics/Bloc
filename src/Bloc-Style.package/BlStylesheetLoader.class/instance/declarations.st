grammar declaration
declarations
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]