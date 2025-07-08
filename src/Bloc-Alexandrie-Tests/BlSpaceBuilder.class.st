"
My purpose is making easier to create BlSpaces with elements.
"
Class {
	#name : #BlSpaceBuilder,
	#superclass : #Object,
	#instVars : [
		'space',
		'spaceExtent',
		'host',
		'alphabetGenerator',
		'colorGenerator'
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
		extent: (Rectangle encompassing: hexagonVertices) extent;
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
	space root
		extent: spaceExtent;
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
	
	space := BlSpace new.
	spaceExtent := 100 asPoint.
	host := BlOSWindowSDL2Host new.

	colorGenerator := self newColorGenerator.
	alphabetGenerator := self newAlphabetGenerator
]

{ #category : #initialization }
BlSpaceBuilder >> newAlphabetGenerator [

	^ Generator on: [ :generator |
		| index |
		index := 1.
		[ 	Character alphabet do: [ :each |
				| next suffix |
				next := each asUppercase asString.
				suffix := index = 1
					ifTrue: [ '' ]
					ifFalse: [ index asString ].
				generator yield: next, suffix ].
			index := index + 1 ] repeat ]
]

{ #category : #initialization }
BlSpaceBuilder >> newColorGenerator [

	| randomColors |
	"The following colors were generated in a Pharo 11 with:
		| random |
		random := Random seed: 7.
		(1 to: 50) collect: [ :_ | Color random: random ].
	They are hardcoded here since Pharo 12 redefined Random, breaking render tests."

	randomColors :=  {
		(Color r: 0.5738025415444771 g: 0.03225806451612903 b: 0.03225806451612903 alpha: 1.0). (Color r: 0.5659824046920822 g: 0.7194525904203324 b: 0.13587487781036167 alpha: 1.0). (Color r: 0.1652003910068426 g: 0.8533724340175953 b: 0.14760508308895406 alpha: 1.0). (Color r: 0.17302052785923755 g: 0.624633431085044 b: 0.7820136852394917 alpha: 1.0). (Color r: 0.5953079178885631 g: 0.3313782991202346 b: 0.624633431085044 alpha: 1.0). (Color r: 0.17595307917888564 g: 0.09090909090909091 b: 0.43206256109481916 alpha: 1.0). (Color r: 0.4173998044965787 g: 0.3548387096774194 b: 0.9530791788856305 alpha: 1.0). (Color r: 0.6656891495601173 g: 0.43499511241446726 b: 0.70772238514174 alpha: 1.0). (Color r: 0.7859237536656891 g: 0.1710654936461388 b: 0.45454545454545453 alpha: 1.0). (Color r: 0.05865102639296188 g: 0.5327468230694037 b: 0.9452590420332356 alpha: 1.0). (Color r: 0.41935483870967744 g: 0.9022482893450635 b: 0.5327468230694037 alpha: 1.0). (Color r: 0.34506353861192574 g: 0.5786901270772239 b: 0.34310850439882695 alpha: 1.0). (Color r: 0.4750733137829912 g: 0.9618768328445748 b: 0.7536656891495601 alpha: 1.0). (Color r: 0.17595307917888564 g: 0.6686217008797654 b: 0.9266862170087976 alpha: 1.0). (Color r: 0.7360703812316716 g: 0.501466275659824 b: 0.37438905180840665 alpha: 1.0). (Color r: 0.20918866080156404 g: 0.4995112414467253 b: 0.5161290322580645 alpha: 1.0). (Color r: 0.6197458455522972 g: 0.4095796676441838 b: 0.5239491691104594 alpha: 1.0). (Color r: 0.2238514173998045 g: 0.9550342130987293 b: 0.27174975562072334 alpha: 1.0). (Color r: 0.375366568914956 g: 0.6197458455522972 b: 0.6432062561094819 alpha: 1.0). (Color r: 0.3998044965786901 g: 0.6539589442815249 b: 0.2913000977517107 alpha: 1.0). (Color r: 0.2541544477028348 g: 0.7683284457478006 b: 0.25219941348973607 alpha: 1.0). (Color r: 0.4232649071358749 g: 0.6744868035190615 b: 0.04398826979472141 alpha: 1.0). (Color r: 0.7810361681329423 g: 0.19941348973607037 b: 0.6774193548387096 alpha: 1.0). (Color r: 0.28152492668621704 g: 0.761485826001955 b: 0.8132942326490714 alpha: 1.0). (Color r: 0.8250244379276638 g: 0.3479960899315738 b: 0.5210166177908113 alpha: 1.0). (Color r: 0.39002932551319647 g: 0.6099706744868035 b: 0.176930596285435 alpha: 1.0). (Color r: 0.38220918866080156 g: 0.8768328445747801 b: 0.3734115347018573 alpha: 1.0). (Color r: 0.8914956011730205 g: 0.555229716520039 b: 0.8025415444770283 alpha: 1.0). (Color r: 0.4916911045943304 g: 0.33822091886608013 b: 0.20430107526881722 alpha: 1.0). (Color r: 0.5317693059628543 g: 0.24926686217008798 b: 0.0009775171065493646 alpha: 1.0). (Color r: 0.40371456500488756 g: 0.45943304007820135 b: 0.6744868035190615 alpha: 1.0). (Color r: 0.5747800586510264 g: 0.7429130009775171 b: 0.9530791788856305 alpha: 1.0). (Color r: 0.9315738025415444 g: 0.07135874877810362 b: 0.6666666666666666 alpha: 1.0). (Color r: 0.5650048875855328 g: 0.09481915933528837 b: 0.3548387096774194 alpha: 1.0). (Color r: 0.44574780058651026 g: 0.24731182795698925 b: 0.23460410557184752 alpha: 1.0). (Color r: 0.5386119257086999 g: 0.14858260019550343 b: 0.14467253176930597 alpha: 1.0). (Color r: 0.5239491691104594 g: 0.2903225806451613 b: 0.8123167155425219 alpha: 1.0). (Color r: 0.3284457478005865 g: 0.541544477028348 b: 0.044965786901270774 alpha: 1.0). (Color r: 0.03519061583577713 g: 0.47116324535679377 b: 0.14076246334310852 alpha: 1.0). (Color r: 0.6617790811339198 g: 0.9481915933528837 b: 0.9296187683284457 alpha: 1.0). (Color r: 0.022482893450635387 g: 0.09188660801564028 b: 0.4125122189638319 alpha: 1.0). (Color r: 0.9814271749755621 g: 0.5571847507331378 b: 0.8113391984359726 alpha: 1.0). (Color r: 0.12609970674486803 g: 0.39002932551319647 b: 0.5601173020527859 alpha: 1.0). (Color r: 0.6275659824046921 g: 0.7390029325513197 b: 0.40860215053763443 alpha: 1.0). (Color r: 0.820136852394917 g: 0.3489736070381232 b: 0.13196480938416422 alpha: 1.0). (Color r: 0.22482893450635386 g: 0.14760508308895406 b: 0.41935483870967744 alpha: 1.0). (Color r: 0.4780058651026393 g: 0.3255131964809384 b: 0.02737047898338221 alpha: 1.0). (Color r: 0.08113391984359726 g: 0.03128054740957967 b: 0.4222873900293255 alpha: 1.0). (Color r: 0.9960899315738025 g: 0.0967741935483871 b: 0.7272727272727273 alpha: 1.0). (Color r: 0.6520039100684262 g: 0.10752688172043011 b: 0.2561094819159335 alpha: 1.0) }.

	^ Generator
		on: [ :generator |
			| nextIndex |
			nextIndex := 0.
			[ generator yield: (randomColors at: nextIndex + 1).
			nextIndex := (nextIndex + 1) \\ randomColors size ] repeat ]
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

	^ colorGenerator next
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
