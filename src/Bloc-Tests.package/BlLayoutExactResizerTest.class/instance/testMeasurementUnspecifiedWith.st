tests
testMeasurementUnspecifiedWith
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementUnspecifiedWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementUnspecifiedWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementUnspecifiedWith: 100.
	self assert: measurement equals: expected.