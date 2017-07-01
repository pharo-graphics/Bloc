tests
testMeasurementExactlyWith
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementExactlyWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementExactlyWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementExactlyWith: 100.
	self assert: measurement equals: expected.