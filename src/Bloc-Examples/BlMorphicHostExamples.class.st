Class {
	#name : #BlMorphicHostExamples,
	#superclass : #BlExamplesTest,
	#instVars : [
		'containerMorph'
	],
	#category : #'Bloc-Examples-Host - Morph'
}

{ #category : #examples }
BlMorphicHostExamples >> squares [
	<sampleInstance>
	<demo>

	| aMorph aHost aSpace |
	aMorph := Morph new.
	"container morph could also have #spaceFill resizing"
	aMorph extent: 400 asPoint.
	"Specify a layout policy so the Bloc space fills the whole
	extent (including Morph resizing)."
	aMorph layoutPolicy: TableLayout new.
	aMorph openInWindowLabeled: 'Resize window to layout. Hover squares to color.'.

	aHost := BlMorphicHost new.
	aHost containerMorph: aMorph.

	aSpace := BlSpace new.
	aSpace host: aHost.
	aSpace show.

	aSpace root
		background: Color paleBlue;
		layout: BlFlowLayout horizontal.

	50 timesRepeat: [ 
		aSpace root addChild:
			(BlElement new
				background: Color random translucent;
				addEventHandlerOn: BlMouseEnterEvent
					do: [ :evt | evt target background: Color random ];
				yourself) ].

	^ aSpace
]
