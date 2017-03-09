rendering
rendererOn: aCanvas
	| renderer |
	spans ifNil: [ self measureOn: aCanvas ].
	renderer := SpSingleLineTextRenderer new layout: self.
	^ renderer