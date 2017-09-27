accessing
pane: aPagerPane
	| titleElement titleText |

	titleText := BrRopedText string: aPagerPane title.
	titleElement := BlTextElement new.
	titleElement text: titleText.
	
	itemElement addChild: titleElement