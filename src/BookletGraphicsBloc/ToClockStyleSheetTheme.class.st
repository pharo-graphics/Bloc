"
Sample stylesheet for ToClock
"
Class {
	#name : #ToClockStyleSheetTheme,
	#superclass : #ToBeeTheme,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #accessing }
ToClockStyleSheetTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'clock-background-color'
			   value: Color lightOrange ).
		  (ToTokenProperty name: #'clock-border-width' value: 4).
		  (ToTokenProperty name: #'clock-border-color' value: Color lightRed ).
		  (ToTokenProperty name: #'clock-border-quarterWidth' value: 8).
		  (ToTokenProperty name: #'clock-border-hourWidth' value: 6).
		  (ToTokenProperty
			   name: #'clock-hour-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-hour-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-minute-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-minute-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-minute-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-minute-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-second-needle-color'
			   value: Color blue).
		  (ToTokenProperty name: #'clock-second-needle-width' value: 3).

		  (ToTokenProperty
			   name: #'clock-background-color-hover'
			   value: Color blue) }
]

{ #category : #accessing }
ToClockStyleSheetTheme class >> label [ 

	^ 'Clock'
]

{ #category : #initialization }
ToClockStyleSheetTheme >> declareClockFrameRules [

	self select: ToClock asTypeSelector style: [
		self do: [ :e | self drawClockFrame: e ].

		self
			write: (self property: #geometry)
			with: [ :e | BlCircleGeometry new matchExtent: e extent ].

		self write: (self property: #background) with: [ :e |
			BlBackground paint:
				(e valueOfTokenNamed: #'clock-background-color') ].

		self write: (self property: #border) with: [ :e |
			BlBorder
				paint: (e valueOfTokenNamed: #'clock-border-color')
				width: (e valueOfTokenNamed: #'clock-border-width') ].

		self
			when: ToLeavedLookEvent
			write: (self property: #background)
			with: [ :e |
				BlBackground paint:
					(e valueOfTokenNamed: #'clock-background-color') ].

		self
			when: ToHoveredLookEvent
			write: (self property: #background)
			with: [ :e |
				BlBackground paint:
					(e valueOfTokenNamed: #'clock-background-color-hover') ] ]
]

{ #category : #initialization }
ToClockStyleSheetTheme >> declareClockNeedlesRules [

	self select: #secondNeedle asIdSelector style: [
		self do: [ :e | e outskirts: BlOutskirts centered ].
		self
			write: (self property: #geometry)
			with: [ :e | BlLineGeometry new ].

		self write: (self property: #border) with: [ :e |
			BlBorder
				paint: (e valueOfTokenNamed: #'clock-second-needle-color')
				width: (e valueOfTokenNamed: #'clock-second-needle-width') ] ].

	self select: #minuteNeedle asIdSelector style: [
		self
			write: (self property: #geometry)
			with: [ :e | BlLineGeometry new ].
		self do: [ :e | e outskirts: BlOutskirts centered ].

		self write: (self property: #border) with: [ :e |
			BlBorder
				paint: (e valueOfTokenNamed: #'clock-minute-needle-color')
				width: (e valueOfTokenNamed: #'clock-minute-needle-width') ] ].

	self select: #hourNeedle asIdSelector style: [
		self
			write: (self property: #geometry)
			with: [ :e | BlLineGeometry new ].
		self do: [ :e | e outskirts: BlOutskirts centered ].

		self write: (self property: #border) with: [ :e |
			BlBorder
				paint: (e valueOfTokenNamed: #'clock-hour-needle-color')
				width: (e valueOfTokenNamed: #'clock-hour-needle-width') ] ]
]

{ #category : #'private - drawing' }
ToClockStyleSheetTheme >> drawClockFrame: e [
	"draw small lines around clock frame"

	| quarterLength quarterWidth hourLength hourWidth radius |
	radius := e extent min / 2.0.
	quarterLength := radius * 4.8 / 20.
	quarterWidth := 8.
	hourLength := radius * 3.2 / 20.
	hourWidth := 6.

	0 to: 11 do: [ :items |
		| coordinate angle |
		angle := items * Float pi / 6.
		coordinate := angle cos @ angle sin.

		items % 3 == 0
			ifTrue: [ "quarter mark"
				e addChild: (BlElement new
						 addStamp: #quaterMark;
						 geometry: (BlLineGeometry
								  from: e center + (coordinate * (radius - quarterLength))
								  to: e center + (coordinate * radius));
						 outskirts: BlOutskirts centered;
						 border: (BlBorder
								  paint: (e valueOfTokenNamed: #'clock-border-color')
								  width: (e valueOfTokenNamed: #'clock-border-quarterWidth'))) ]
			ifFalse: [ "other hour marks"
				e addChild: (BlElement new
						 addStamp: #hourMark;
						 geometry: (BlLineGeometry
								  from: e center + (coordinate * (radius - hourLength))
								  to: e center + (coordinate * radius));
						 outskirts: BlOutskirts centered;
						 border: (BlBorder
								  paint: (e valueOfTokenNamed: #'clock-border-color')
								  width: (e valueOfTokenNamed: #'clock-border-hourWidth'))) ] ]
]

{ #category : #'helper methods' }
ToClockStyleSheetTheme >> dummyMethod [ 
"from ToThemeExamples class >> example_WithLateBoundPropertyWriter"
|parent|
	parent
		addEventHandlerOn: ToThemePreInstallEvent 
		do: [ :event |
			event currentTarget lookupTheme addTokenProperty:
				(ToTokenProperty name: #'my-red-color' value: Color red) ].
	parent localTheme: ToBeeTheme new.
]

{ #category : #initialization }
ToClockStyleSheetTheme >> initializeStyleRules [ 

	super initializeStyleRules.
	self declareClockFrameRules.
	self declareClockNeedlesRules.
]
