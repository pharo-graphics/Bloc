paragraph - measuring
measuredHabaWithPadding
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self habaParagraph.
	aParagraph padding: self padding.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 4.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: (0 @ self ascent) + self padding topLeft.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 4.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: self haba size * self glyphWidth.
	
	aSpan := aLine spans first.
	self assert: aSpan advance equals: self haba size * self glyphWidth.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: (0 @ self ascent) + self padding topLeft.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 1. 
	self assert: aSpan height equals: self height.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 4. 
	self assert: aSpan spanStart equals: 1.
	self assert: aSpan textRun equals: self haba.
	self assert: aSpan textRunEnd equals: 4.
	self assert: aSpan textRunStart equals: 1.
	self assert: aSpan to equals: 4.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: (self haba size * self glyphWidth).
	
	self assert: aSpan spanLength equals: 4.
	self assert: aSpan textRunLength equals: 4.
	self assert: aSpan isSplitted not.
	
	^ aParagraph