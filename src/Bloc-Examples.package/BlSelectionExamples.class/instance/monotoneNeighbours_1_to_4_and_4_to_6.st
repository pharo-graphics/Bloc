examples - monotone selection
monotoneNeighbours_1_to_4_and_4_to_6
	<gtExample>
	| from1to4 from4to6 |
	
	from1to4 := self monotoneSelect_from_1_to_4.
	from4to6 := self monotoneSelect_from_4_to_6.

	self assert: (from1to4 neighbours: from4to6).
	self assert: (from4to6 neighbours: from1to4).

	^ (from1to4 neighbours: from4to6)