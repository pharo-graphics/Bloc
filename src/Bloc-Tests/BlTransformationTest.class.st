Class {
	#name : #BlTransformationTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests-Core'
}

{ #category : #'tx bounds tests' }
BlTransformationTest >> testElTxBoundsWithScale [
	| g n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	g := BlElement new
		size: 200 @ 200;
		relocate: 10 @ 10;
		addChild: n;
		yourself.

	n transform
		scaleBy: 2@2;
		apply.
	g transform
		scaleBy: 2@2;
		apply.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (90 @ 90) negated.
	self assert: n positionInSpace equals: (170 @ 170) negated. 
	self assert: n transformedBounds equals: ((50@50) negated extent: (200@200)).
	self assert: g transformedBounds equals: ((100@100) negated extent: (400@400)).
]

{ #category : #'tx bounds tests' }
BlTransformationTest >> testScaleBy [
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n transform
		scaleBy: (2 @ 2);
		apply.

	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (40 @ 40) negated. 
	self assert: n transformedBounds equals: ((50 @ 50) negated corner: (150@150)).
	
	n transform
		inherit;
		scaleBy: (0.5 @ 0.5);
		apply.
	n forceLayout.
	self assert: n transformedBounds equals: ((0@0) corner: (100@100)).
	

]

{ #category : #'tx bounds tests' }
BlTransformationTest >> testScaleTo [
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n transform
		scaleBy: (2 @ 2);
		apply.
	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (40 @ 40) negated. 
	self assert: n transformedBounds equals: ((50 @ 50) negated corner: (150@150)).
	
	n transform
		scaleBy: (0.5 @ 0.5);
		apply.
	n forceLayout.
	self assert: n transformedBounds equals: ((25@25) corner: (75@75)).
	

]

{ #category : #'tx bounds tests' }
BlTransformationTest >> testTranslateTo [
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n transform
		translateBy: (10 @ 10);
		apply.
		
	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (20 @ 20). 
	self assert: n transformedBounds equals: ((10@10) corner: (110@110)).
	
	n transform
		translateBy: (30 @ 30);
		apply.
	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (40 @ 40). 
	self assert: n transformedBounds equals: ((30@30) corner: (130@130))
]
