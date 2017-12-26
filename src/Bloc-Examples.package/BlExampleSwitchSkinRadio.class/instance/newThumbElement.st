instance creation
newThumbElement
	^ BlElement new
		geometry: BlEllipse new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]