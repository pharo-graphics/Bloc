Extension { #name : 'BlSpaceFixture' }

{ #category : '*Bloc-SVG-Tests' }
BlSpaceFixture >> buildSVGStrokes [

	| parent |
	builder spaceExtent: 240@120.

	parent := builder addToRoot
		background: BlBackground transparent;
		transformDo: [ :b | b scaleBy: 0.2; translateBy: -25 @ -15 ];
		clipChildren: false;
		yourself.

	#( 'M200,300 Q400,50 600,300 T1000,300'
		'M300,200 h-150 a150,150 0 1,0 150,-150 z'
		'M275,175 v-150 a150,150 0 0,0 -150,150 z'
		'M600,350 l 50,-25
           a25,25 -30 0,1 50,-25 l 50,-25
           a25,50 -30 0,1 50,-25 l 50,-25
           a25,75 -30 0,1 50,-25 l 50,-25
           a25,100 -30 0,1 50,-25 l 50,-25'
		'M200,300 L400,50 L600,300 L800,550 L1000,300'
		'M100,200 C100,100 250,100 250,200 S400,300 400,200')
		do: [ :each |
			| aGeometry anElement |
			aGeometry := BlSvgPath pathString: each.
			anElement := aGeometry asElement
				background: Color transparent;
				border: (BlBorder paint: builder nextColor width: 4);
				beOutskirtsCentered;
				yourself.
			parent addChild: anElement ]
]
