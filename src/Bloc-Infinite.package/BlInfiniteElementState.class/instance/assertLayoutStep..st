asserting
assertLayoutStep: aStep
	"Make sure that current layout step is aStep"

	(layoutStep has: aStep)
		ifFalse: [ self error: 'Wrong layout state! It should be: ', aStep asString, ' but it is ', layoutStep value asString ]