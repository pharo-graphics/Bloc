*Bloc
preservingClipByLocal: aLocalRectangle global: aGlobalRectangle during: aBlock
	| oldClip |
	oldClip := currentClipRect.
	currentClipRect := oldClip
		ifNil: [ aGlobalRectangle ]
		ifNotNil: [ oldClip intersect: aGlobalRectangle ifNone: [ ^ self ] ].
	self primSave.
	self
		setPathMatrix;
		setClipRectPreserve: aLocalRectangle.
	aBlock
		ensure: [ 
			self primRestore.
			currentClipRect := oldClip ]