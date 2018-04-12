examples - monotone selection
monotoneNeighbours_1_to_3_and_4_to_6
	<gtExample>
	| from1to3 from4to6 |
	
	from1to3 := self monotoneSelect_from_1_to_3.
	from4to6 := self monotoneSelect_from_4_to_6.
	
	self assert: (from1to3 neighbours: from4to6).
	self assert: (from4to6 neighbours: from1to3).
	
	^ (from1to3 neighbours: from4to6)