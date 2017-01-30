drawing
drawOn: aCanvas
	super drawOn: aCanvas.
	
	hostSpace ifNotNil: [ 
		hostSpace lock critical: [
			aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
				aClippedCanvas drawImage: form at: self position ] ] ]