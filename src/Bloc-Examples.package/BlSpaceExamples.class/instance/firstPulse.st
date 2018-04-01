lifecycle
firstPulse
	<gtExample>
	| aSpace |
	
	aSpace := self emptySpace.
	aSpace pulse.
	
	self assert: aSpace dirtyAreas asArray equals: { BlBounds origin: 0@0 extent: aSpace extent }.
	self assert: aSpace root position equals: 0@0.
	self assert: aSpace root extent equals: aSpace extent.

	^ aSpace