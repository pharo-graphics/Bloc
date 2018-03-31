asserting
assertLayoutStep: aStep or: anotherStep
	"Make sure that current layout step is aStep"

	((layoutStep has: aStep) or: [ layoutStep has: anotherStep ])
		ifFalse: [ self error: 'Wrong layout state! It should be: ', aStep asString, ' or ', anotherStep asString, ' but it is ', layoutStep value asString ]