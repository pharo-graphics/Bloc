examples - monotone selection
monotoneNeighbours_1_to_3_and_1_to_1
	<gtExample>
	| from1to3 from1to1 |
	
	from1to3 := self monotoneSelect_from_1_to_3.
	from1to1 := self monotoneSelect_from_1_to_1.
	
	self assert: (from1to3 neighbours: from1to1) not.
	self assert: (from1to1 neighbours: from1to3) not.
	
	^ (from1to3 neighbours: from1to1)