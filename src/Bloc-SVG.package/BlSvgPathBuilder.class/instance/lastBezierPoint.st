operations
lastBezierPoint
	segments reverseDo: [ :arr | arr first caseOf: { 
		[ #relative ] -> [ "ignore" ] } ]