"
Skin description of the Second needle for ToClock
"
Class {
	#name : #ToSecondNeedleClockSkin,
	#superclass : #ToRawSkin,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #'event handling' }
ToSecondNeedleClockSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e
			geometry: BlLineGeometry new;
			outskirts: BlOutskirts centered;
			border:(BlBorder
					 paint: (e valueOfTokenNamed: #'clock-second-needle-color')
					 width: (e valueOfTokenNamed: #'clock-second-needle-width')) ]
]
