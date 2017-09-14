circle & ellipse
ellipsePositionFrom: node
	| cx cy |
	cx := cy := 0.
	node attributeAt: 'cx' ifPresent: [ cx := (node attributeAt: 'cx') asNumber ].
	node attributeAt: 'cy' ifPresent: [ cy := (node attributeAt: 'cy') asNumber ].
	^ (cx - (node attributeAt: 'rx') asNumber) @ (cy - (node attributeAt: 'ry') asNumber)