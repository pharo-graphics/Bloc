updating
updateMatching
	matchOnId := self selectors anySatisfy: [ :s | s matchesOnId ].
	matchOnName := self selectors anySatisfy: [ :s | s matchesOnName ].
	matchOnStyleClass := self selectors anySatisfy: [ :s | s matchesOnStyleClass ]