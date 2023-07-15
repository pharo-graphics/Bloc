"
My purpose is making easier to create BlSpaces with elements.
"
Class {
	#name : #BlSpaceBuilder,
	#superclass : #Object,
	#instVars : [
		'space',
		'random',
		'spaceExtent',
		'host',
		'alphabetGenerator'
	],
	#category : #'Bloc-Alexandrie-Tests-Utilities'
}

{ #category : #convenience }
BlSpaceBuilder class >> newSpaceWith: aUnaryBlockClosure [

	^ self new newSpaceWith: aUnaryBlockClosure
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addCircle [

	^ self addToRoot
		geometry: BlCircleGeometry new;
		yourself
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addHexagonalPolygon [
	"Answer an hexagon polygon."

	| hexagonVertices |
	hexagonVertices := { 
		 60 @  0.
		 20 @  0.
		  0 @ 36.
		 20 @ 70.
		 60 @ 70.
		 80 @ 36 }.

	^ self addToRoot
		geometry: (BlPolygonGeometry vertices: hexagonVertices);
		size: (Rectangle encompassing: hexagonVertices) extent;
		yourself
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addPolyline [
	"Answer a simple polyline of 3 vertices. Polylines are open, then don't look good with other outskirts than centered."

	^ self addToRoot
		background: Color transparent;
		geometry: (BlPolylineGeometry vertices: { 20@4. 0@0. 4@20 });
		outskirts: BlOutskirts centered;	
		yourself
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addText: aBlRopedText to: parentElement [

	| anElement |
	anElement := BlTextElement new
		text: aBlRopedText;
		id: alphabetGenerator next;
		yourself.
	parentElement addChild: anElement.
	^ anElement

]

{ #category : #'adding elements' }
BlSpaceBuilder >> addTextToRoot: aBlRopedText [

	^ self addText: aBlRopedText to: space root
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addTo: parentElement [

	| anElement |
	anElement := BlElement new
		id: alphabetGenerator next;
		background: self nextColor;
		yourself.
	parentElement addChild: anElement.
	^ anElement

]

{ #category : #'adding elements' }
BlSpaceBuilder >> addToRoot [

	^ self addTo: space root
]

{ #category : #'adding elements' }
BlSpaceBuilder >> addTriangle [

	^ self addToRoot
		geometry: BlTriangleGeometry new;
		yourself
]

{ #category : #building }
BlSpaceBuilder >> buildSpace [
	"Make last set up before user can use the space."

	space
		host: host;
		extent: spaceExtent.

	self flag: #todo. "Hacky way to prepare stuff without showing the space:"
	space layerHolder
		size: spaceExtent;
		forceLayout.
]

{ #category : #accessing }
BlSpaceBuilder >> host [

	^ host
]

{ #category : #accessing }
BlSpaceBuilder >> host: aBlHost [

	host := aBlHost
]

{ #category : #initialization }
BlSpaceBuilder >> initialize [

	super initialize.
	
	space := BlOSpace new.
	spaceExtent := 100 asPoint.
	host := BlOSWindowSDL2Host new.

	random := Random seed: 7.
	alphabetGenerator := Generator on: [ :generator |
		| index |
		index := 1.
		[ 	Character alphabet do: [ :each |
				| next suffix |
				next := each asUppercase asString.
				suffix := index = 1
					ifTrue: [ '' ]
					ifFalse: [ index asString ].
				generator yield: next, suffix ].
			index := index + 1 ] repeat ].

]

{ #category : #'instance creation' }
BlSpaceBuilder >> newSpaceWith: aUnaryBlockClosure [

	aUnaryBlockClosure value: self.
	^ self
		  buildSpace;
		  space
]

{ #category : #accessing }
BlSpaceBuilder >> nextColor [

	^ Color random: random
]

{ #category : #accessing }
BlSpaceBuilder >> space [

	^ space
]

{ #category : #accessing }
BlSpaceBuilder >> spaceExtent [

	^ spaceExtent
]

{ #category : #accessing }
BlSpaceBuilder >> spaceExtent: aPoint [

	spaceExtent := aPoint
]
