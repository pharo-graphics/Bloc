"
A BlAffineTransformationOriginTest is a test class for testing the behavior of BlAffineTransformationOrigin
"
Class {
	#name : #BlAffineTransformationOriginTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Transformations'
}

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationCenterOrigin [

	self assert: BlAffineTransformationCenterOrigin new equals: BlAffineTransformationCenterOrigin new
]

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationLeftCenterOrigin [

	self
		assert: BlAffineTransformationLeftCenterOrigin new
		equals: BlAffineTransformationLeftCenterOrigin new
]

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationNormalizedPositionOrigin [

	self
		assert: (BlAffineTransformationNormalizedPositionOrigin new position: 0.5 @ 0.5; yourself)
		equals: (BlAffineTransformationNormalizedPositionOrigin new position: 0.5 @ 0.5; yourself).
	self
		deny: (BlAffineTransformationNormalizedPositionOrigin new position: 0.0 @ 0.5; yourself)
		equals: (BlAffineTransformationNormalizedPositionOrigin new position: 0.5 @ 0.5; yourself)
]

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationPositionOrigin [

	self
		assert: (BlAffineTransformationPositionOrigin new
				 position: 0.5 @ 0.5;
				 yourself)
		equals: (BlAffineTransformationPositionOrigin new
				 position: 0.5 @ 0.5;
				 yourself).
	self
		deny: (BlAffineTransformationPositionOrigin new
				 position: 0.0 @ 0.5;
				 yourself)
		equals: (BlAffineTransformationPositionOrigin new
				 position: 0.5 @ 0.5;
				 yourself)
]

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationRightCenterOrigin [

	self
		assert: BlAffineTransformationRightCenterOrigin new
		equals: BlAffineTransformationRightCenterOrigin new
]

{ #category : #tests }
BlAffineTransformationOriginTest >> testEqualityBlAffineTransformationTopLeftOrigin [

	self
		assert: BlAffineTransformationTopLeftOrigin new
		equals: BlAffineTransformationTopLeftOrigin new
]
