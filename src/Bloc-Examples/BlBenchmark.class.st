"
I am a collection of extreme bloc benchmarks.

If you have so many UI elements in your application as we have in benchmarks (except modelling and visualisations) then you do something wrong ;)
"
Class {
	#name : #BlBenchmark,
	#superclass : #Object,
	#category : #'Bloc-Examples-Experimental'
}

{ #category : #'nested bench' }
BlBenchmark class >> createSquareAnd4SubSquaresLength: aLength min: aMin [
|theRoot pos|
theRoot := BlElement new
	background:Color random;
	size: (aLength ) asPoint;
	when: BlMouseOverEvent do:[:e| e target background: Color random asBlBackground].

(aLength <= aMin) ifTrue:[^ theRoot] .
pos := (aLength/2)+1.
theRoot addChildren:{
	((self  createSquareAnd4SubSquaresLength:( aLength/2) integerPart asInteger -2 min: aMin) position:1@1).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:pos@1).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:1@pos).
	((self  createSquareAnd4SubSquaresLength: ( aLength/2) integerPart asInteger -2 min: aMin) position:pos@pos).
	}.
	
^ theRoot
]

{ #category : #'nested bench' }
BlBenchmark class >> createSquareAnd9SubSquaresLength: aLength min: aMin [
|theRoot pos|
theRoot := BlElement new
	background:Color random;
	size: aLength asPoint;
	when: BlMouseOverEvent do:[:e| e target background: Color random asBlBackground].

(aLength <= aMin) ifTrue:[^ theRoot] .
pos := (aLength/3)+1.
theRoot addChildren:{
	((self  createSquareAnd9SubSquaresLength:( aLength/3) integerPart asInteger -3 min: aMin) position:1@1).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:pos@1).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:(pos*2)@1).
	
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:1@pos).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:pos@pos).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3 min: aMin) position:(pos*2)@pos).
	
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:1@(pos*2)).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:pos@(pos*2)).
	((self  createSquareAnd9SubSquaresLength: ( aLength/3) integerPart asInteger -3  min: aMin) position:(pos*2)@(pos*2)).
	}.
	
^ theRoot
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_10800El10x10_inWin1200x900_mouseMove50ms [
	|space anim|
	space := BlSpace new.
	
	0 to: 90 do:[:y|
		0 to: 120 do:[:x|
		|s currentPosition|	
			currentPosition := (x*10) @ (y*10).
			s := BlElement new
					size: 10@10;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					when: BlMouseOverEvent do:[:e| e target background: Color random];
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


anim := BlAnimation new
	delay:50;
	duration:1;
	loops:100;
	onFinishedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space eventListener handleEvent: (BlMouseMoveEvent new
		position: pos).
		
	 ].
space root userData at: #anim put: anim.

space extent: 1024@768.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_19200El_in800x600 [
	|space|
	space := BlSpace new.
	
	0 to: 120 do:[:y|
		0 to:160 do:[:x|
		|s currentPosition|	
			currentPosition := (x*5) @ (y*5).
			s := BlElement new
					size: 5@5;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					when: BlMouseOverEvent  do:[:e| e target background:Color white];
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space extent: 800@600.
space show.
BlBenchmarkConsoleSpecModel onSpace: space
]

{ #category : #'nested bench' }
BlBenchmark class >> example_21846nestedEl_in800x800_mouseMove50ms [
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd4SubSquaresLength: 800 min: 5.

space root addChild: child.	
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


"anim := BlAnimation new
	delay:15;
	duration:1;
	cycleCount:500;
	onPerformedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space hostWindow ifNil:[^ self].
		space hostWindow eventFetcher enqueue: (BlMouseMoveEvent new
		position: pos).
		
	 ].
child userData at: #anim put: anim."

space extent: 800@800.
space show.
"anim start.
BlDevToolSpecModel onSpace: space"
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_2500El_in_1800x960 [
	|sp|
	sp := BlSpace new.
	0 to: 50 do:[:y|
		0 to:50 do:[:x|
		|s currentPosition|	
			currentPosition := (x*50) @ (y*50).
			s := BlElement new
					size: 50@50;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 2);
					when: BlMouseOverEvent do:[:e| e target background: Color random];
					yourself.
			sp root addChild: s
  ]].
sp root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
sp extent: 1800@960.
sp show.

BlBenchmarkConsoleSpecModel onSpace: sp
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_3LevelsOf100El [
	|space|
	space := BlSpace new.
	1 to:3 do:[:i|
		0 to: 10 do:[:y|
			0 to:10 do:[:x|
			|s currentPosition|	
				currentPosition := (x*50) @ (y*50).
				s := BlElement new
					size: 50@50;
					relocate: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width:2);
					yourself.
				space root addChild:s
  ]]].
"space root addChild: (BlFPSCounter on:space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space show.
BlBenchmarkConsoleSpecModel onSpace: space
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_4800El_in800x600 [
	|space|
	space := BlSpace new.
	
	0 to: 60 do:[:y|
		0 to:80 do:[:x|
		|s currentPosition|	
			currentPosition := (x*10) @ (y*10).
			s := BlElement new
					size: 10@10;
					position: currentPosition;
					background: Color random;
					border: (BlBorder paint: Color random width: 1);
					when: BlMouseOverEvent do:[:e| e target background: Color random];
					yourself.
			space root addChild:s
  ]].
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).
space extent: 800@600.
space show.
BlBenchmarkConsoleSpecModel onSpace: space
]

{ #category : #'as yet unclassified' }
BlBenchmark class >> example_4El_in800x600 [
	| space |
	space := BlSpace new.
	0 to: 1 do: [ :y | 
		0 to: 1 do: [ :x | 
			| s currentPosition |
			currentPosition := (x * 50) @ (y * 50).
			s := BlElement new
				size: 50 @ 50;
				relocate: currentPosition;
				background: Color random;
				border: (BlBorder paint: Color random width: 5);
				when: BlMouseOverEvent do: [ :e | e target background: Color random ];
				yourself.
			space root addChild: s ] ].
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space extent: 800 @ 600.
	space show
]

{ #category : #'nested bench' }
BlBenchmark class >> example_5462nestedEl_in800x800_mouseMove50ms [
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd4SubSquaresLength: 800 min: 15.

space root addChild: child.	
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


anim := BlAnimation new
	delay:15;
	duration:1;
	loops:500;
	onFinishedDo: [ 
		|pos|
		pos := (750 atRandom)@(750 atRandom).
		space hostSpace ifNil:[^ self].
		space hostSpace enqueueEvent: (BlMouseMoveEvent new
		position: pos).
		
	 ].
child userData at: #anim put: anim.

space extent: 800@800.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space
]

{ #category : #'nested bench' }
BlBenchmark class >> example_821nestedEl_in1000x1000_mouseMove50ms [
	|space child anim|
	space := BlSpace new.
	child := self createSquareAnd9SubSquaresLength: 1000 min: 50.

space root addChild: child.	
"space root addChild: (BlFPSCounter on: space)."
space root addEventHandler: (BlEventHandler 
on:BlDoubleClickEvent do:[:evt|  BlElementSelection on: evt target. ]).


anim := BlAnimation new
	delay:15;
	duration:1;
	loops:500;
	onFinishedDo: [ 
		|pos|
		pos := (900 atRandom)@(900 atRandom).
		space hostSpace ifNil: [ ^ self ].
		space hostSpace enqueueEvent: (BlMouseMoveEvent new position: pos) ].
child userData at: #anim put: anim.

space extent: 1000@1000.
space show.
anim start.
BlBenchmarkConsoleSpecModel onSpace: space
]
