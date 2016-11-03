updating
updateSpecificity
	| idCount styleClassCount nameCount pseudoClassCount |
	idCount := self selectors sum: [ :s | s idCount ].
	styleClassCount := self selectors sumNumbers: [ :s | s styleClassCount ].
	pseudoClassCount := self selectors sumNumbers: [ :s | s pseudoClassCount ].
	nameCount := self selectors sum: [ :s | s nameCount ].
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount