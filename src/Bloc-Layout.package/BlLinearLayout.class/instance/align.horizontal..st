api - alignment
align: aChildElement horizontal: aBlAlignment
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]