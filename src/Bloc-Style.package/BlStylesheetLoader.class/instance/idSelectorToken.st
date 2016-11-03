grammar selector
idSelectorToken
	^ super idSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]