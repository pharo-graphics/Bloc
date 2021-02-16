"
An AkGroupTest is a test class for testing the behavior of AkGroup
"
Class {
	#name : #BlGeometryTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Geometry'
}

{ #category : #testing }
BlGeometryTest class >> shouldInheritSelectors [
	^ true
	
]

{ #category : #'contains tests' }
BlGeometryTest >> test3ElContainsPoint [
	| g c1 c2 |

	c1 := BlElement new
		size: 200 @ 100;
		relocate: 100 @ 100;
		background: Color yellow;
		yourself.

	c2 := BlElement new
		size: 400 @ 300;
		relocate: 100 @ 100;
		background: Color red;
		addChild: c1;
		yourself.

	g := BlElement new
		size: 700 @ 500;
		relocate: 0 @ 0;
		background: Color blue;
		addChild: c2;
		yourself.

	g forceLayout.

	self assert: (c1 containsGlobalPoint: (250@250)).
	self assert: (c2 containsGlobalPoint: (250@250)).
	self assert: (g containsGlobalPoint: (250@250)).

	self assert: (c1 containsPoint: (50@50))
]

{ #category : #'any bounds tests' }
BlGeometryTest >> testElAnyBounds [
	| g c1 c2 |
	c1 := BlElement new
		size: 200 @ 100;
		relocate: 100 @ 100;
		yourself.
	c2 := BlElement new
		size: 400 @ 300;
		relocate: 100 @ 100;
		addChild: c1;
		yourself.
	g := BlElement new
		size: 700 @ 500;
		relocate: 0 @ 0;
		addChild: c2;
		yourself.
		
	g forceLayout.

	self assert: g positionInSpace equals: (0 @ 0).
	self assert: c2 positionInSpace equals: (100 @ 100).
	self assert: c1 positionInSpace equals: (200 @ 200).
	
	self assert: g geometryBoundsInSpace equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 geometryBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g effectBounds equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 effectBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 effectBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g boundsInLocal equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 boundsInLocal equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 boundsInLocal equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g bounds inParent asRectangle equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 bounds inParent asRectangle equals: ((100 @ 100) corner:(500@400)).
	self assert: c1 bounds inParent asRectangle equals: ((100 @ 100) corner:(300@200)).
	
	self assert: g transformedBounds equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 transformedBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 transformedBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g geometryBoundsInSpace equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBoundsInSpace equals: ((100 @ 100) corner:(500@400)).
	self assert: c1 geometryBoundsInSpace equals: ((200 @ 200) corner:(400@300)).
	
	
]

{ #category : #'bounds tests' }
BlGeometryTest >> testElLocalAndGlobalBoundsConvertion [
	| g |
	g := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: g geometryBounds equals: (0 @ 0 corner: 100 @ 100).
	self assert: g geometryBoundsInSpace equals: (10 @ 10 corner: 110 @ 110).
	
	self assert: (g globalBoundsToLocal: (BlBounds fromRectangle:(10 @ 10 corner: 110 @ 110))) asRectangle equals: g geometryBounds.
	"is the same as"
	self assert: (g localBoundsToGlobal: (BlBounds fromRectangle: g geometryBounds)) asRectangle equals: (10 @ 10 corner: 110 @ 110)
]

{ #category : #'position tests' }
BlGeometryTest >> testElLocalAndGlobalPostionConvertion [
	| g n |
	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.
		
	g := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		addChild: n;
		yourself.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (10 @ 10).
	self assert: n positionInSpace equals: (20 @ 20).
	self assert: (n parentPointToLocal: n position) equals: (0@0).
]

{ #category : #'tx bounds tests' }
BlGeometryTest >> testElTxBounds [
	| g n |
	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.
	g := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		addChild: n;
		yourself.
		
	g forceLayout.

	self assert: g position = (10 @ 10).
	self assert: n position = (10 @ 10).
	self assert: g positionInSpace = (10 @ 10).
	self assert: n positionInSpace = (20 @ 20).
	self assert: n transformedBounds  = ((0@0) corner:(100@100)).
	self assert: g transformedBounds  = ((0@0) corner:(100@100)).
]
