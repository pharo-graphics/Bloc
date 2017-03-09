rendering
rendererOn: aCanvas
	| renderer |
	lines ifNil: [ self measureOn: aCanvas ].
	renderer := SpMultilineTextRenderer new layout: self.
	^ renderer