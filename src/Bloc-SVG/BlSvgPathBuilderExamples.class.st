Class {
	#name : #BlSvgPathBuilderExamples,
	#superclass : #Object,
	#category : 'Bloc-SVG-Examples'
}

{ #category : #commands }
BlSvgPathBuilderExamples >> _1_moveAbsoluteTo [
	<gtExample>
	| aBuilder |

	aBuilder := self pathBuilder.
	aBuilder absolute.
	aBuilder moveTo: 10@10.

	self assert: aBuilder segments size equals: 1.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).

	^ aBuilder
]

{ #category : #commands }
BlSvgPathBuilderExamples >> _2_lineAbsoluteTo [
	<gtExample>
	| aBuilder |
	
	aBuilder := self _1_moveAbsoluteTo.
	aBuilder absolute.
	aBuilder lineTo: 20@20.

	self assert: aBuilder segments size equals: 2.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).

	^ aBuilder
]

{ #category : #commands }
BlSvgPathBuilderExamples >> _3_moveRelativeTo [
	<gtExample>
	| aBuilder |
	
	aBuilder := self _2_lineAbsoluteTo.
	aBuilder relative.
	aBuilder moveTo: 5 negated asPoint.

	self assert: aBuilder segments size equals: 3.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).
	self assert: aBuilder segments third equals: (BlSvgPathMoveSegment relative moveTo: (-5)@(-5)).

	^ aBuilder
]

{ #category : #commands }
BlSvgPathBuilderExamples >> _4_lineRelativeTo [
	<gtExample>
	| aBuilder |
	
	aBuilder := self _3_moveRelativeTo.
	aBuilder relative.
	aBuilder lineTo: 10@25.

	self assert: aBuilder segments size equals: 4.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).
	self assert: aBuilder segments third equals: (BlSvgPathMoveSegment relative moveTo: (-5)@(-5)).
	self assert: aBuilder segments fourth equals: (BlSvgPathLineSegment relative lineTo: 10@25).

	^ aBuilder
]

{ #category : #builders }
BlSvgPathBuilderExamples >> pathBuilder [
	<gtExample>

	^ BlSvgPathBuilder new
]
