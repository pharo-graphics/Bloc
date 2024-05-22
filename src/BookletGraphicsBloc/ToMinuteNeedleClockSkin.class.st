"
Skin description of the Minute needle for ToClock
"
Class {
	#name : #ToMinuteNeedleClockSkin,
	#superclass : #ToRawSkin,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #'event handling' }
ToMinuteNeedleClockSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e
			geometry: BlLineGeometry new;
			outskirts: BlOutskirts centered;
			border: (BlBorder
					 paint: (e valueOfTokenNamed: #'clock-minute-needle-color')
					 width: (e valueOfTokenNamed: #'clock-minute-needle-width')) ]
]
