grammar selector
pseudoClassSelectorToken
	^ super pseudoClassSelectorToken
		==> [ :nodes | BlState fromSymbol: nodes inputValue allButFirst asSymbol ]