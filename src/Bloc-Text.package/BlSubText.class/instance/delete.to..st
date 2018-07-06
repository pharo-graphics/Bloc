text - modifications
delete: aStart to: anEnd
	text delete: start + aStart - 1 to: start + anEnd - 1.
	end := end - (anEnd - aStart + 1)