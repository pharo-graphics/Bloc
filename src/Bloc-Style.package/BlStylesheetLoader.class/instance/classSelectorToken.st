grammar selector
classSelectorToken
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]