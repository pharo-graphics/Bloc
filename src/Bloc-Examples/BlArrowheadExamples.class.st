"
I contain examples of different types of ==BlArrowheadElement==
"
Class {
	#name : #BlArrowheadExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'Bloc-Examples-Geometry'
}

{ #category : #examples }
BlArrowheadExamples class >> curveWithCircleArrowheads [
	<script: 'self curveWithCircleArrowheads'>
	
	self
		openInWindow: self new curveWithCircleArrowheads
		named: 'Circle arrowheads'
		extent: 550@500
]

{ #category : #examples }
BlArrowheadExamples class >> curveWithSimpleArrowArrowheads [
	<script: 'self curveWithSimpleArrowArrowheads'>
	
	self
		openInWindow: self new curveWithSimpleArrowArrowheads
		named: 'Simple arrow arrowheads'
		extent: 550@500
]

{ #category : #examples }
BlArrowheadExamples class >> curveWithSimpleRoundedArrowArrowheads [
	<script: 'self curveWithSimpleRoundedArrowArrowheads'>
	
	self
		openInWindow: self new curveWithSimpleRoundedArrowArrowheads
		named: 'Simple rounded arrow arrowheads'
		extent: 550@500
]

{ #category : #examples }
BlArrowheadExamples class >> curveWithTriangleArrowheads [
	<script: 'self curveWithTriangleArrowheads'>
	
	self
		openInWindow: self new curveWithTriangleArrowheads
		named: 'Triangle arrowheads'
		extent: 550@500
]

{ #category : #'instance creation' }
BlArrowheadExamples >> circleArrowhead [
	<gtExample>
	
	^ BlArrowheadCircle new
		background: self headColor;
		border: (BlBorder paint: self curveColor)
]

{ #category : #'instance creation' }
BlArrowheadExamples >> curveColor [
	^ Color gray alpha: 0.5
]

{ #category : #'instance creation' }
BlArrowheadExamples >> curveWidth [
	^ 25
]

{ #category : #examples }
BlArrowheadExamples >> curveWithCircleArrowheads [
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self circleArrowhead.
	curve toHead: self circleArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container
]

{ #category : #'instance creation' }
BlArrowheadExamples >> curveWithDifferentArrowheads [
	<gtExample>

	| container curve |
	container := BlParabollaExamples new relativeCurvature.
	container := BlBezierElementExamples new curveWithAnchors.
	curve := container children first.
	curve fromHead: (BlArrowheadSimpleArrow new
			arrowLengthFraction: 5;
			arrowNoseAngle: 60;
			border: (BlBorder paint: (Color red alpha: 0.5) width: 10)).
	curve toHead: (BlArrowheadCircle new
		background: (Color red alpha: 0.2);
		border: (BlBorder paint: (Color red alpha: 0.5) width: 5)).
	curve border: (BlBorder paint: (Color red alpha: 0.5) width: 10).
	^ container
]

{ #category : #examples }
BlArrowheadExamples >> curveWithSimpleArrowArrowheads [
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self simpleArrowArrowhead.
	curve toHead: self simpleArrowArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container
]

{ #category : #examples }
BlArrowheadExamples >> curveWithSimpleRoundedArrowArrowheads [
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self simpleRoundedArrowArrowhead.
	curve toHead: self simpleRoundedArrowArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container
]

{ #category : #examples }
BlArrowheadExamples >> curveWithTriangleArrowheads [
	<gtExample>
	| container curve |
	
	container := BlParabollaExamples new relativeCurvatureWithoutDecorations.
	curve := container children first.
	
	curve fromHead: self triangleArrowhead.
	curve toHead: self triangleArrowhead.
	curve border: (BlBorder paint: self curveColor width: self curveWidth).
	
	^ container
]

{ #category : #'instance creation' }
BlArrowheadExamples >> headColor [
	^ Color gray alpha: 0.2
]

{ #category : #'instance creation' }
BlArrowheadExamples >> simpleArrowArrowhead [
	<gtExample>

	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: 3;
		arrowNoseAngle: 45;
		border: (BlBorder paint: self curveColor width: 15);
		background: self curveColor
]

{ #category : #'instance creation' }
BlArrowheadExamples >> simpleRoundedArrowArrowhead [
	<gtExample>

	^ BlArrowheadSimpleArrow new
		arrowLengthFraction: 3;
		arrowNoseAngle: 60;
		border: (BlBorder builder joinRound paint: self curveColor; width: 20; build);
		background: self curveColor
]

{ #category : #'instance creation' }
BlArrowheadExamples >> triangleArrowhead [
	<gtExample>

	^ BlArrowheadTriangle new
		background: self headColor;
		border: (BlBorder paint: self curveColor width: 5)
]
