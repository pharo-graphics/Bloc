measure
matchingMeasure: anElement
	"Measure children of anElement that match breadth of anElement"
	| matchingMeasureSpec |
	"create a measurement spec with exact size equal to element's measured breadth"
	matchingMeasureSpec := BlMeasurementSpec new beExact: (self orientation measuredBreadth: anElement).
	
	self measuredChildren: anElement do: [ :child |
		"we measure only those who match parent along breadth axis"
		(self orientation breadthProperties: child) resizer ifMatchParent: [
			|oldResizing|
			"store vertical resizing of child. It can be anything,
			but to success matching it should be exact and equal to already
			measured length"
			oldResizing := (self orientation lengthProperties: child) resizer.
			"switch resizing mode to exact"
			(self orientation lengthProperties: child) exact: (self orientation measuredLength: child).
			"measure child with parent's length spec and our created matching spec 
			in a role of breadth spec"
			self orientation 
				measureChildWithMargin: child
				parentSpec: (self orientation 
					extentSpecBreadth: matchingMeasureSpec
					lengthSpec: self orientation lengthSpec)
				breadthUsed: 0
				lengthUsed: 0.
			"restore previous resizing"
			(self orientation lengthProperties: child) resizer: oldResizing ] ]