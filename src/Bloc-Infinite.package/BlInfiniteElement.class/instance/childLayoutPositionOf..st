children - accessing
childLayoutPositionOf: anElement
	"Return the datasource position of the given child element as of the latest completed layout pass.
	This position may not be equal to Item's datasource position if there are pending changes
	in the datasource which have not been reflected to the layout yet"
	<return: #Number>

	^ (self elementHolderOf: anElement) layoutPosition
