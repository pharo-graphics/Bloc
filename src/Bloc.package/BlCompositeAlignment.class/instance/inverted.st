factory
inverted
	^ (self class horizontal: (vertical inverted directed: direction) vertical: (horizontal directed: direction) inverted)
		directed: direction;
		yourself