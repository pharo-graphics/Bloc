instance creation
verticalList
	"<gtExample>"
	
	^ BlInfiniteExampleElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself