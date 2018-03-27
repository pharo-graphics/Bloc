api - alignment
align: aChildElement vertical: aBlAlignment
	"I should be used to dispatch children alignment configuration through layout to provide higher level uniform alignment api.	
	Layouts that support children alignment should override me as follows:
	
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]

	"