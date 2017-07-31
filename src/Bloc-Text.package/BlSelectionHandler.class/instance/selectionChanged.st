selection
selectionChanged
	"Is sent when #selectionArea changed"
	
	selection
		relocate: self selectionArea origin;
		size: self selectionArea extent.
		
	