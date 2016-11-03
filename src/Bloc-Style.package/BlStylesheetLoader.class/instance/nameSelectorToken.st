grammar selector
nameSelectorToken
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]