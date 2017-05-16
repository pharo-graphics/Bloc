drawing
drawOn: aCanvas
	| spaceForm |
	super drawOn: aCanvas.
	
	spaceForm := form.
	hostSpace ifNotNil: [ 
		hostSpace lock critical: [
			aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
				aClippedCanvas drawImage: spaceForm at: self position ] ] ]