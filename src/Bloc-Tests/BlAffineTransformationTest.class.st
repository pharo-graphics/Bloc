"
A BlAffineTransformationTest is a test class for testing the behavior of BlAffineTransformation
"
Class {
	#name : #BlAffineTransformationTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Transformations'
}

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlAffineCompositeTransformation [

	self
		assert: (BlAffineCompositeTransformation new
				 addTransformation: (BlShearTransformation new angleX: 80);
				 addTransformation: (BlRotationTransformation new angle: 80);
				 yourself)
		equals: (BlAffineCompositeTransformation new
				 addTransformation: (BlShearTransformation new angleX: 80);
				 addTransformation: (BlRotationTransformation new angle: 80);
				 yourself).
	"Same transform but in different order should be ko"
	self
		deny: (BlAffineCompositeTransformation new
		 addTransformation: (BlRotationTransformation new angle: 80);
				 addTransformation: (BlShearTransformation new angleX: 80);
				 yourself)
		equals: (BlAffineCompositeTransformation new
				 addTransformation: (BlShearTransformation new angleX: 80);
				 addTransformation: (BlRotationTransformation new angle: 80);
				 yourself).
	
	self
		deny: (BlAffineCompositeTransformation new
				 addTransformation: (BlShearTransformation new angleX: 80);
				 addTransformation: (BlRotationTransformation new angle: 80);
				 yourself)
		equals: (BlAffineCompositeTransformation new
				 addTransformation: (BlShearTransformation new angleX: 80);
				 addTransformation: (BlRotationTransformation new angle: 70);
				 yourself)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlMatrixTransformation [

	self
		assert: (BlMatrixTransformation new
				 matrix: BlMatrix3D new;
				 yourself)
		equals: (BlMatrixTransformation new
				 matrix: BlMatrix3D new;
				 yourself).
	self
		deny: (BlMatrixTransformation new
				 matrix: BlMatrix3D new;
				 yourself)
		equals: (BlMatrixTransformation new
				 matrix: (BlMatrix3D new rotateByDegrees: 50 around: BlVector zAxis);
				 yourself)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlPerspectiveTransformation [

	self
		assert: (BlPerspectiveTransformation new
				 depth: 20;
				 yourself)
		equals: (BlPerspectiveTransformation new
				 depth: 20;
				 yourself).
	self
		deny: (BlPerspectiveTransformation new
				 depth: 20;
				 yourself)
		equals: (BlPerspectiveTransformation new
				depth: 30;
				 yourself)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlReflectionTransformation [

	self
		assert: (BlReflectionTransformation new reflection: BlVector xAxis; yourself)
		equals: (BlReflectionTransformation new reflection: BlVector xAxis; yourself).
	self
		deny: (BlReflectionTransformation new reflection: BlVector xAxis; yourself)
		equals: (BlReflectionTransformation new reflection: BlVector yAxis; yourself)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlRotationTransformation1 [

	self
		assert: (BlRotationTransformation new angle: 80)
		equals: (BlRotationTransformation new angle: 80).
	self
		deny: (BlRotationTransformation new angle: 80)
		equals: (BlRotationTransformation new angle: 180)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlRotationTransformation2 [

	self
		assert: (BlRotationTransformation new angle: 80; axis: BlVector yAxis; yourself)
		equals: (BlRotationTransformation new angle: 80; axis: BlVector yAxis; yourself).
	self
		deny: (BlRotationTransformation new angle: 80; axis: BlVector yAxis; yourself)
		equals: (BlRotationTransformation new angle: 80; axis: BlVector xAxis; yourself)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlScalingTransformation [

	self
		assert: (BlScalingTransformation new scale: 50 @ 50)
		equals: (BlScalingTransformation new scale: 50 @ 50).
	self
		deny: (BlScalingTransformation new scale: 50 @ 50)
		equals: (BlScalingTransformation new scale: 20 @ 50)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlShearTransformation [

	self
		assert: (BlShearTransformation new angleX: 80)
		equals: (BlShearTransformation new angleX: 80).
		self
		assert: (BlShearTransformation new angleY: 80)
		equals: (BlShearTransformation new angleY: 80).
	self
		deny: (BlShearTransformation new angleX: 80)
		equals: (BlShearTransformation new angleY: 80)
]

{ #category : #tests }
BlAffineTransformationTest >> testEqualityBlTranslationTransformation [

	self assert: (BlTranslationTransformation new translation: 50 @ 50) equals: (BlTranslationTransformation new translation: 50 @ 50).
	self deny: (BlTranslationTransformation new translation: 50 @ 50) equals: (BlTranslationTransformation new translation: 20 @ 50).
]
