as yet unclassified
+ aKeyCodeCombination
	self assert: [ self class = aKeyCodeCombination class ].
	^ BlCombinationSequence withAll: { self . aKeyCodeCombination }