as yet unclassified
for: aSelectorString style: aBlock
	| theSelectors theRule |
	theSelectors := BlStylesheetLoader parseSelectors: aSelectorString.
	theRule := BlStyleRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule