tests
testMeasurementAtMostWith
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementAtMostWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementAtMostWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementAtMostWith: 100.
	self assert: measurement equals: expected.