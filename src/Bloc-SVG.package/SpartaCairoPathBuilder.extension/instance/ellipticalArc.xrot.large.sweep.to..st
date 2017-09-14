*Bloc-SVG
ellipticalArc: radii xrot: rotationAxis large: largeFlag sweep: sweepFlag to: aPoint
	|center startAngle endAngle x y cx cy cosAxis sinAxis factor|
	self flag:'Does not work properly yet'.
	cosAxis := rotationAxis degreeCos.
	sinAxis := rotationAxis degreeSin.
	
	"Conversion from endpoint to center parameterization"
	x := cosAxis*(endPoint x - (aPoint x))/2 + ( sinAxis*(endPoint y - (aPoint y))/2 ).
	y := (0-sinAxis)*(endPoint x - (aPoint x))/2 + ( cosAxis*(endPoint y - (aPoint y))/2 ).
	
	factor := ( ((radii x squared)*(radii y squared)) - ((radii x squared)*(y squared)) - ((radii y squared)*(x squared)) ) / ( ((radii x squared)*(y squared)) + ((radii y squared)*(x squared)) ) sqrt.
	largeFlag = sweepFlag ifFalse:[cx := factor*(radii x)*y/(radii y).
											cy := (factor*(radii y)*x/(radii x)) negated.]
		ifTrue:[cx := (factor*(radii x)*y/(radii y)) negated.
				cy := factor*(radii y)*x/(radii x).].
	self flag:'The center is off'.
	center := ((endPoint x + (aPoint x))/2) + (cosAxis*cx) - (sinAxis*cy) @ ((endPoint y + (aPoint y))/2) + (sinAxis*cx) + (cosAxis*cy).
	Transcript cr; show:center.
	
	startAngle := self angleOfVector: ( ((x-cx)/radii x) @ ((y-cy)/radii y) ).
	endAngle := self angleOfVector: ( ((0-x-cx)/radii x) @ ((0-y-cy)/radii y) ).
		
	"Translating and Scaling context to achieve an elliptical arc instead of a circular arc, thus making radii x the appropriate radius"
	self primTranslateByX: center x AndY: center y.
	self primScaleContextByX: 1 AndY: (radii y / (radii x)).
	
	sweepFlag = 0 ifFalse:[ self primArcCenterX: 0 centerY: 0 radius: radii x startAngle: startAngle endAngle: endAngle ]
		ifTrue:[ self primArcNegativeCenterX: 0 centerY: 0 radius: radii x startAngle: startAngle endAngle: endAngle ].
		
	"Reverting the changes to the context"
	self primScaleContextByX: 1 AndY: (radii x / (radii y)).
	self primTranslateByX: center x negated AndY: center y negated.
	
	"Adjusting endPoint and lastControlPoint"
	lastControlPoint := nil.
	endPoint := aPoint.