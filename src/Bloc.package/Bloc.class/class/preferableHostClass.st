accessing
preferableHostClass
	^ PreferableHostClass ifNil: [ BlHost defaultHostClass ]