bounds
clippedTriangle
	<gtExample>
	<label: 'Clipped triangle polygon with layount bounds'>
	| aContainer aPolygonElement |
	aContainer := BlElement new.
	aContainer size: 8@11.
	aContainer relocate: 20@20.
	aContainer clipChildren: true.
	aContainer transformDo: [ :t |
	    t origin: BlAffineTransformationTopLeftOrigin new.
	    t scaleBy: 10 ].
	aContainer border: (BlBorder paint: (Color green alpha: 0.4) width: 0.2).

	aPolygonElement := BlElement new.
	aPolygonElement size: 8@11.
	aPolygonElement geometry: (BlPolygon vertices: { 0@0 . 8@5.5. 0@11 }).
	aPolygonElement border: (BlBorder paint: (Color gray alpha: 0.4) width: 2).
	aPolygonElement outskirts: BlOutskirts centered.

	aContainer addChild: aPolygonElement.

	^ aContainer