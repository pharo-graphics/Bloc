"
# Annulus sector
In mathematics, an annulus (the Latin word for ""little ring"" is anulus / annulus, with plural anuli / annuli) is a ring-shaped object, a region bounded by two concentric circles.

<https://en.wikipedia.org/wiki/Annulus_(mathematics)>

By default, {{gtClass:BlAnnulusSector}} is set up to represent a sector of the annulus:
{{gtExample:BlAnnulusSectorExamples>>#default|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

The geometry allows users to customize the sector via:
 - {{gtMethod:BlAnnulusSector>>#startAngle:}} - start angle given in degrees counting clockwise from the right most point
 - {{gtMethod:BlAnnulusSector>>#endAngle:}} - end angle given in degrees counting clockwise from the right most point
 - {{gtMethod:BlAnnulusSector>>#innerRadius:}} - the size of the inner circle given as a fraction [0..1] of the maximum possible radius
 - {{gtMethod:BlAnnulusSector>>#outerRadius:}} - the size of the outer circle given as a fraction [0..1] of the maximum possible radius

We can control the sector by playing with `startAngle:` and `endAngle:`
{{gtExample:BlAnnulusSectorExamples>>#annulusSectorTopRight|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}
{{gtExample:BlAnnulusSectorExamples>>#annulusSectorBottomRight|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}
{{gtExample:BlAnnulusSectorExamples>>#annulusSectorBottomLeft|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}
{{gtExample:BlAnnulusSectorExamples>>#annulusSectorTopLeft|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

If the overall sector is equal or more than 360 degrees then the sector turns into a annulus:
{{gtExample:BlAnnulusSectorExamples>>#annulus|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

If inner radius is 0, then the annulus sector degrades to circle sector:
{{gtExample:BlAnnulusSectorExamples>>#circleSector|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

This we can create a pac-man shaped sector:
{{gtExample:BlAnnulusSectorExamples>>#pacman|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

If in addition to that the angle is >=360 we get a circle:
{{gtExample:BlAnnulusSectorExamples>>#circle|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

"
Class {
	#name : #BlAnnulusSectorExamples,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #examples }
BlAnnulusSectorExamples >> annulus [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> annulusSectorBottomLeft [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> annulusSectorBottomRight [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> annulusSectorTopLeft [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> annulusSectorTopRight [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> circle [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> circleSector [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> default [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new.
	
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
BlAnnulusSectorExamples >> outerRadiusSmallerThanInner [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> pacman [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> radiiOutsideOfValidInterval [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
BlAnnulusSectorExamples >> sameRadii [
	<gtExample>
	| aSector |
	
	aSector := BlAnnulusSector new
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
