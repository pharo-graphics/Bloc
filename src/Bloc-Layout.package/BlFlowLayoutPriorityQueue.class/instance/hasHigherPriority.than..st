private
hasHigherPriority: aNodeA than: aNodeB

	^ aNodeA priority < aNodeB priority
		or: [ aNodeA priority = aNodeB priority
			and: [ aNodeA insertionIndex < aNodeB insertionIndex ] ]