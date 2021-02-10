"
! Annulus sector
In mathematics, an annulus (the Latin word for ""little ring"" is anulus / annulus, with plural anuli / annuli) is a ring-shaped object, a region bounded by two concentric circles.

*https://en.wikipedia.org/wiki/Annulus_(mathematics)*

By default, ${class:BlAnnulusSector}$ is set up to represent a sector of the annulus:
${example:BlAnnulusSectorExamples>>#default|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$

The geometry allows users to customize the sector via:
 - ${method:BlAnnulusSector>>#startAngle:}$ - start angle given in degrees counting clockwise from the right most point
 - ${method:BlAnnulusSector>>#endAngle:}$ - end angle given in degrees counting clockwise from the right most point
 - ${method:BlAnnulusSector>>#innerRadius:}$ - the size of the inner circle given as a fraction [0..1] of the maximum possible radius
 - ${method:BlAnnulusSector>>#outerRadius:}$ - the size of the outer circle given as a fraction [0..1] of the maximum possible radius

We can control the sector by playing with ==startAngle:== and ==endAngle:==
${example:BlAnnulusSectorExamples>>#annulusSectorTopRight|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$
${example:BlAnnulusSectorExamples>>#annulusSectorBottomRight|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$
${example:BlAnnulusSectorExamples>>#annulusSectorBottomLeft|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$
${example:BlAnnulusSectorExamples>>#annulusSectorTopLeft|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$

If the overall sector is equal or more than 360 degrees then the sector turns into a annulus:
${example:BlAnnulusSectorExamples>>#annulus|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$

If inner radius is 0, then the annulus sector degrades to circle sector:
${example:BlAnnulusSectorExamples>>#circleSector|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$

This we can create a pac-man shaped sector:
${example:BlAnnulusSectorExamples>>#pacman|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$

If in addition to that the angle is >=360 we get a circle:
${example:BlAnnulusSectorExamples>>#circle|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}$
"
Class {
	#name : #BlAnnulusSectorGeometryExamplesMigrated,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> annulus [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 0;
		endAngle: 360.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.45.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 22.5.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> annulusSectorBottomLeft [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 90;
		endAngle: 180;
		innerRadius: 0.5;
		outerRadius: 1.0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 90.
	self assert: aSector endAngle equals: 180.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> annulusSectorBottomRight [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 0;
		endAngle: 90;
		innerRadius: 0.5;
		outerRadius: 1.0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 90.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> annulusSectorTopLeft [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 180;
		endAngle: 270;
		innerRadius: 0.5;
		outerRadius: 1.0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 180.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> annulusSectorTopRight [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 270;
		endAngle: 360;
		innerRadius: 0.5;
		outerRadius: 1.0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 270.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> circle [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 0;
		endAngle: 360;
		innerRadius: 0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 360.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> circleSector [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 0;
		endAngle: 270;
		innerRadius: 0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> default [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.45.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 22.5.
	
	^ aSector
]

{ #category : #'examples - corner cases' }
BlAnnulusSectorGeometryExamplesMigrated >> outerRadiusSmallerThanInner [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		innerRadius: 1.0;
		outerRadius: 0.5.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 1.
	self assert: aSector outerRadius equals: 0.5.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 25.0.
	self assert: aSector absoluteInnerRadius equals: 50.0.
	
	^ aSector
]

{ #category : #examples }
BlAnnulusSectorGeometryExamplesMigrated >> pacman [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		startAngle: 45;
		endAngle: 315;
		innerRadius: 0.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 45.
	self assert: aSector endAngle equals: 315.
	self assert: aSector innerRadius equals: 0.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.
	
	^ aSector
]

{ #category : #'examples - corner cases' }
BlAnnulusSectorGeometryExamplesMigrated >> radiiOutsideOfValidInterval [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		innerRadius: -10;
		outerRadius: 20.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.0.
	self assert: aSector outerRadius equals: 1.0.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 50.0.
	self assert: aSector absoluteInnerRadius equals: 0.0.
	
	^ aSector
]

{ #category : #'examples - corner cases' }
BlAnnulusSectorGeometryExamplesMigrated >> sameRadii [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSectorGeometry new
		innerRadius: 0.5;
		outerRadius: 0.5.
	
	self assert: aSector extent equals: 150@100.
	self assert: aSector startAngle equals: 0.
	self assert: aSector endAngle equals: 270.
	self assert: aSector innerRadius equals: 0.5.
	self assert: aSector outerRadius equals: 0.5.
	
	self assert: aSector radius equals: 50.0.
	self assert: aSector center equals: 75.0@50.0.
	self assert: aSector absoluteOuterRadius equals: 25.0.
	self assert: aSector absoluteInnerRadius equals: 25.0.
	
	^ aSector
]
