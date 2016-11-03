private utilities
setGroup: child row: row span: rowSpan col: col span: colSpan

	child constraints vertical specSpan: (row to: row + rowSpan).
	child constraints horizontal specSpan: (col to: col + colSpan)