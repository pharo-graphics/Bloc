examples - monotone selection
monotoneNeighbours_1_to_3_and_3_to_4
	<gtExample>
	| from1to3 from3to4 |
	
	from1to3 := self monotoneSelect_from_1_to_3.
	from3to4 := self monotoneSelect_from_3_to_4.
	
	self assert: (from1to3 neighbours: from3to4) not.
	self assert: (from3to4 neighbours: from1to3) not.
	
	^ (from1to3 neighbours: from3to4)