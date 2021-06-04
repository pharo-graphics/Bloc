"
# Bloc children composition

Each visual element in `Bloc` is composed out of other elements using a composition design pattern.


"
Class {
	#name : #BlElementChildrenExamples,
	#superclass : #BlElementExamples,
	#category : #'Bloc-Examples-Basic'
}

{ #category : #'examples - enumeration' }
BlElementChildrenExamples >> allLeafChildrenAt_100_200 [
	<gtExample>
	| aContainer theChildren |
	
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 100@200.
	
	self assert: theChildren equals: { aContainer childNamed: #red }.
	
	^ theChildren
]

{ #category : #'examples - enumeration' }
BlElementChildrenExamples >> allLeafChildrenAt_200_100 [
	<gtExample>
	| aContainer theChildren |

	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200@100.

	self assert: theChildren equals: { aContainer childNamed: #blue }.

	^ theChildren
]

{ #category : #'examples - enumeration' }
BlElementChildrenExamples >> allLeafChildrenAt_200_200 [
	<gtExample>
	| aContainer theChildren |
	
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200@200.
	
	self assert: theChildren equals: { aContainer childNamed: #blue. aContainer childNamed: #red }.
	
	^ theChildren
]

{ #category : #'examples - enumeration' }
BlElementChildrenExamples >> allLeafChildrenAt_50_50 [
	<gtExample>
	| aContainer theChildren |
	
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 50@50.
	
	self assert: theChildren equals: { aContainer }.
	
	^ theChildren
]

{ #category : #'examples - enumeration' }
BlElementChildrenExamples >> allLeafChildrenAt_600_600 [
	<gtExample>
	| aContainer theChildren |
	
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 600@600.
	
	self assert: theChildren equals: { }.
	
	^ theChildren
]

{ #category : #'instance creation' }
BlElementChildrenExamples >> overlappingChildren [
	<gtExample>
	| aContainer aRedChild aBlueChild |
	
	aContainer := BlElement new
		size: 400@400;
		background: Color veryVeryLightGray;
		labeled: 'Container'.
		
	aRedChild := BlElement new
		size: 300@150;
		relocate: 50@125;
		background: (Color red alpha: 0.5);
		labeled: 'Red'.

	aBlueChild := BlElement new
		size: 150@300;
		relocate: 125@50;
		background: (Color blue alpha: 0.5);
		labeled: 'Blue'.

	aContainer addChild: aRedChild as: #red.
	aContainer addChild: aBlueChild as: #blue.

	aContainer forceLayout.

	^ aContainer
]
