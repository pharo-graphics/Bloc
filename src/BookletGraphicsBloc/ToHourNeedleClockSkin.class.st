"
Skin description of the hour needle for ToClock
"
Class {
	#name : #ToHourNeedleClockSkin,
	#superclass : #ToRawSkin,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #'event handling' }
ToHourNeedleClockSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e
			geometry: BlLineGeometry new;
			outskirts: BlOutskirts centered;
			border: (BlBorder
					 paint: (e valueOfTokenNamed: #'clock-hour-needle-color')
					 width: (e valueOfTokenNamed: #'clock-hour-needle-width')) ]
]
