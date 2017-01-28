drawing
drawOn: aCanvas
	super drawOn: aCanvas.
	
	aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
		aClippedCanvas drawImage: form at: self position ]