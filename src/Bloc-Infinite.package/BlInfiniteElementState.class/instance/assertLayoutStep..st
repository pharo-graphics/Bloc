asserting
assertLayoutStep: aStep
	"Make sure that current layout step is aStep"
	
	self
		assert: [ layoutStep has: aStep ]
		description: [ 'Wrong layout state! It should be: ', aStep asString, ' but it is ', layoutStep value asString ]