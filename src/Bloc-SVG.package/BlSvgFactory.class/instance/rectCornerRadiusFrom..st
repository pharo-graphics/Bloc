rectangle
rectCornerRadiusFrom: node
	|rx ry maxRadius maxAllowed|
	rx := ry := 0.
	node attributeAt:'rx' ifPresent: [ rx:= (node attributeAt:'rx') asNumber].
	node attributeAt:'ry' ifPresent: [ rx:= (node attributeAt:'ry') asNumber].
	
	maxRadius :=  rx max: ry.
	maxAllowed := ( (node attributeAt:'width') asNumber min: ((node attributeAt:'height') asNumber) ) / 2.
	^ maxRadius min: maxAllowed
			