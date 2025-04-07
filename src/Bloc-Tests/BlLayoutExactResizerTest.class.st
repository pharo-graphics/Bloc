Class {
	#name : #BlLayoutExactResizerTest,
	#superclass : #TestCase,
	#instVars : [
		'resizer'
	],
	#category : #'Bloc-Tests-Layouts-Support'
}

{ #category : #initialization }
BlLayoutExactResizerTest >> setUp [
	super setUp.
	
	resizer := BlLayoutExactResizer new size: 100.0
]

{ #category : #tests }
BlLayoutExactResizerTest >> testEquals [
	
	self
		assert: (BlLayoutExactResizer zero)
		equals: (BlLayoutExactResizer zero).
	
	self
		assert: (BlLayoutExactResizer new size: 10.0)
		equals: (BlLayoutExactResizer new size: 10.0).

	self
		assert: (BlLayoutExactResizer new size: 10.0) ~= (BlLayoutExactResizer new size: 20.0).

	self
		assert: (BlLayoutExactResizer new size: 10.0) ~= (BlLayoutResizer fitContent).
]

{ #category : #tests }
BlLayoutExactResizerTest >> testHash [

	self
		assert: (BlLayoutExactResizer new size: 10.0) hash
		equals: (BlLayoutExactResizer new size: 10.0) hash.
]

{ #category : #tests }
BlLayoutExactResizerTest >> testIfExact [
	| isExact |
	
	isExact := false.
	resizer ifExact: [ :aResizer | isExact := aResizer == resizer ].
	
	self assert: isExact
]

{ #category : #tests }
BlLayoutExactResizerTest >> testIsExact [
	self assert: resizer isExact
]

{ #category : #tests }
BlLayoutExactResizerTest >> testMeasurementAtMostWith [
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementAtMostWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementAtMostWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementAtMostWith: 100.
	self assert: measurement equals: expected.
]

{ #category : #tests }
BlLayoutExactResizerTest >> testMeasurementExactlyWith [
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementExactlyWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementExactlyWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementExactlyWith: 100.
	self assert: measurement equals: expected.
]

{ #category : #tests }
BlLayoutExactResizerTest >> testMeasurementUnspecifiedWith [
	"In case of exact resizer measurements are forced to be of exact size"
	| expected measurement |
	
	expected := BlMeasurementSpec exact: resizer size.

	measurement := resizer measurementUnspecifiedWith: 0.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementUnspecifiedWith: 50.
	self assert: measurement equals: expected.
	
	measurement := resizer measurementUnspecifiedWith: 100.
	self assert: measurement equals: expected.
]

{ #category : #tests }
BlLayoutExactResizerTest >> testSize [
	| testResizer |
	
	testResizer := BlLayoutExactResizer new.
	testResizer size: 75.0.
	self assert: testResizer size equals: 75.0.
	
	testResizer := BlLayoutExactResizer new.
	testResizer size: 150.0.
	self assert: testResizer size equals: 150.0
]
