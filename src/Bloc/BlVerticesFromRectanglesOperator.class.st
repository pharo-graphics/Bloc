Class {
	#name : 'BlVerticesFromRectanglesOperator',
	#superclass : 'Object',
	#category : 'Bloc-Basic-Geometry',
	#package : 'Bloc',
	#tag : 'Basic-Geometry'
}

{ #category : 'accessing' }
BlVerticesFromRectanglesOperator class >> oppositeDelimiterBackgroundColor [
	^ Color lightGray
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> maxXRightCoord: yCoord fromRectangles: aListOfRectangles [
	" optimized with compiled in-line primitives "

	| l mostRight |
	l := self rectanglesAtY: yCoord fromRectangles: aListOfRectangles.
	mostRight := l first right.
	2 to: l size do: [ :pos | mostRight := mostRight max: (l at: pos) right ].
	^ mostRight
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> minXLeftCoord: yCoord fromRectangles: aListOfRectangles [
	"optimized with compiled in-line primitives "

	| l mostLeft |
	l := self rectanglesAtY: yCoord fromRectangles: aListOfRectangles.
	mostLeft := l first left.
	2 to: l size do: [ :pos | mostLeft := mostLeft min: (l at: pos) left ].
	^ mostLeft
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> rectanglesAtY: anY fromRectangles: aListOfRectangles [

	| rectsAtYExcBottomLines |
	rectsAtYExcBottomLines := self rectsAtYExcBottomLines: anY fromRectangles: aListOfRectangles.
	rectsAtYExcBottomLines ifNotEmpty: [ ^ rectsAtYExcBottomLines ].
	^ self rectsAtYIncBottomLines: anY fromRectangles: aListOfRectangles
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> rectsAtYExcBottomLines: anY fromRectangles: aListOfRectangles [

	^ Array streamContents: [ :stream | aListOfRectangles do: [ :rect |
			(rect top <= anY and: [ rect bottom > anY ]) ifTrue: [ stream nextPut: rect ] ]]
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> rectsAtYIncBottomLines: anY fromRectangles: aListOfRectangles [

	^ Array streamContents: [ :stream | aListOfRectangles do: [ :rect |
			(rect top <= anY and: [ rect bottom = anY ]) ifTrue: [ stream nextPut: rect ] ]]
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> verticesFromRectangles: aListOfRectangles [

	| ret yCoords previousLeftCoord previousRightCoord |
	ret := OrderedCollection new.
	yCoords := self yCoordsFromRectangles: aListOfRectangles.
	yCoords := yCoords sort: [ :a :b | a < b ].
	previousLeftCoord := 0.
	previousRightCoord := 0.
	yCoords do: [ :yCoord | 
		| minimumXLeftCoord maximumXRightCoord first |
		minimumXLeftCoord := self minXLeftCoord: yCoord fromRectangles: aListOfRectangles.
		maximumXRightCoord := self maxXRightCoord: yCoord fromRectangles: aListOfRectangles.
		first := yCoords first.
		yCoord = yCoords first
			ifTrue: [ ret add: minimumXLeftCoord @ yCoord ]
			ifFalse: [ 
				minimumXLeftCoord ~= previousLeftCoord ifTrue: [ ret add: previousLeftCoord @ yCoord beforeIndex: 1 ].
				ret add: minimumXLeftCoord @ yCoord beforeIndex: 1.
				maximumXRightCoord ~= previousRightCoord ifTrue: [ ret add: previousRightCoord @ yCoord ] ].
		ret add: maximumXRightCoord @ yCoord.
		previousLeftCoord := minimumXLeftCoord.
		previousRightCoord := maximumXRightCoord ].
	^ ret
]

{ #category : 'private - vertices computing' }
BlVerticesFromRectanglesOperator >> yCoordsFromRectangles: aListOfRectangles [

	| allBotoms allTops allCoords |
	allBotoms := aListOfRectangles collect: [ :rect | rect bottom ].
	allTops := aListOfRectangles collect: [ :rect | rect top ].
	allCoords := Set new.
	allCoords addAll: allTops.
	allCoords addAll: allBotoms.
	^ allCoords asArray
]
