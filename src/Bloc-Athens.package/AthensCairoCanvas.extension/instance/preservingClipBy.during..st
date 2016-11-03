*Bloc-Athens
preservingClipBy: aRectangle during: aBlock
	| oldClip  |
	oldClip := currentClipRect.
	" Works only if aRectangle is given according to a global coordinate reference"
	currentClipRect := oldClip ifNil: [ aRectangle ] ifNotNil: [ oldClip intersect: aRectangle ifNone:[^ self] ]. 
	self primSave.
	self
		setPathMatrix;
		setClipRectPreserve: aRectangle.
	aBlock
		ensure: [ 
			self primRestore.
			currentClipRect := oldClip ]