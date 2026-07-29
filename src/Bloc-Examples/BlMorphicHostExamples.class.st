Class {
	#name : #BlMorphicHostExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Host - Morph'
}

{ #category : #scripts }
BlMorphicHostExamples class >> openSquares [
	<script>

	| aMorph aHost aSpace |
	aMorph := Morph new.
	aMorph extent: 400 asPoint.
	aMorph layoutPolicy: TableLayout new.
	aMorph openInWindowLabeled: 'Resize window to layout. Hover squares to color.'.

	aHost := BlMorphicHost new.
	aHost containerMorph: aMorph.

	aSpace := BlSpace new.
	aSpace host: aHost.
	aSpace root addChild: self new squares.
	aSpace show.
]

{ #category : #examples }
BlMorphicHostExamples >> squares [
	<demo>

	| parent |
	parent := BlElement new
		background: Color paleBlue;
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	50 timesRepeat: [ 
		parent addChild:
			(BlElement new
				size: 40@40;
				margin: (BlInsets all: 4);
				background: Color random translucent;
				addEventHandlerOn: BlMouseEnterEvent
					do: [ :evt | evt target background: Color random ];
				yourself) ].

	^ parent
]
