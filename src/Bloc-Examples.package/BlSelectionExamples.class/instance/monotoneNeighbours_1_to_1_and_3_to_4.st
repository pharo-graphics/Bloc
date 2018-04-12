examples - monotone selection
monotoneNeighbours_1_to_1_and_3_to_4
	<gtExample>
	| from1to1 from3to4  |
	
	from1to1 := self monotoneSelect_from_1_to_1.
	from3to4 := self monotoneSelect_from_3_to_4.
	
	self assert: (from3to4 neighbours: from1to1) not.
	self assert: (from1to1 neighbours: from3to4) not.
	
	^ (from3to4 neighbours: from1to1)