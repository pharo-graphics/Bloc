api - alignment
align: aChildElement vertical: aBlAlignment
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]