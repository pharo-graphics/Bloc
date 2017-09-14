polyline & polygon
polylineFrom: node
	| polyline points lastPoint|
	polyline := BlElement new.
	
	points := self pointsFrom: node.
	lastPoint := BlAbsolutePositionAnchor position: points first.
	points do: [ :point | polyline addChild: ((self lineFrom: node) fromAnchor: lastPoint; toAnchor: (BlAbsolutePositionAnchor position: point)).
		lastPoint := polyline children last toAnchor
	]without: points first.
		
	self commonPropertiesFrom: node attributes on: polyline.	
	
	^ polyline
