grammar media
mediaCondition
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]