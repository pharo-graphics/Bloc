private utilities
setGroup: child row: row span: rowSpan col: col span: colSpan
	| childConstraints |
	childConstraints := child constraints grid.
	childConstraints vertical specSpan: (row to: row + rowSpan).
	childConstraints horizontal specSpan: (col to: col + colSpan)