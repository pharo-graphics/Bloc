operations
lastBezierPoint
	path reverseDo: [ :arr | arr first caseOf: { 
		[ #relative ] -> [ "ignore" ] } ]