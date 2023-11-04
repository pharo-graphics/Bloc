"
I have been automatically converted and probably manually tweaked from BlAnnulusSectorExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlAnnulusSectorGeometryTest,
	#superclass : #BlGeometryTest,
	#package : 'Bloc',
	#tag : 'UnitedTests-Geometry'
}

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testAnnulus [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 0;
		           endAngle: 360.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.45.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 22.5.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testAnnulusSectorBottomLeft [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 90;
		           endAngle: 180;
		           innerRadius: 0.5;
		           outerRadius: 1.0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 90.
	self assert: aSector endAngle equals: 180.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testAnnulusSectorBottomRight [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 0;
		           endAngle: 90;
		           innerRadius: 0.5;
		           outerRadius: 1.0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 90.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testAnnulusSectorTopLeft [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 180;
		           endAngle: 270;
		           innerRadius: 0.5;
		           outerRadius: 1.0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 180.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testAnnulusSectorTopRight [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 270;
		           endAngle: 360;
		           innerRadius: 0.5;
		           outerRadius: 1.0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 270.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testCircle [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 0;
		           endAngle: 360;
		           innerRadius: 0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testCircleSector [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 0;
		           endAngle: 270;
		           innerRadius: 0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testDefault [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.45.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 22.5.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testOuterRadiusSmallerThanInner [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           innerRadius: 1.0;
		           outerRadius: 0.5.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 1.
	self assert: aSector outerRadius equals: 0.5.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 25.0.
	self assert: aSector absoluteInnerRadius equals: 50.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testPacman [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           startAngle: 45;
		           endAngle: 315;
		           innerRadius: 0.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 45.
	self assert: aSector endAngle equals: 315.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testRadiiOutsideOfValidInterval [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           innerRadius: -10;
		           outerRadius: 20.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.0.
	self assert: aSector outerRadius equals: 1.0.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.0.
	^ aSector
]

{ #category : #tests }
BlAnnulusSectorGeometryTest >> testSameRadii [

	<sampleInstance>
	| aSector |
	aSector := BlAnnulusSectorGeometry new
		           innerRadius: 0.5;
		           outerRadius: 0.5.
	self assert: aSector extent equals: 150 @ 100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 0.5.
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0 @ 50.0.
	self assert: aSector absoluteOuterRadius equals: 25.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	^ aSector
]
