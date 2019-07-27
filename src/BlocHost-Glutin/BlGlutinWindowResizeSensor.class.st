Class {
	#name : #BlGlutinWindowResizeSensor,
	#superclass : #GlutinWindowEventsSensor,
	#category : #'BlocHost-Glutin'
}

{ #category : #'event - handling' }
BlGlutinWindowResizeSensor >> processGlutinEvent: aGlutinWindowEvent forWindow: aWindow [
	(aGlutinWindowEvent isKindOf: GlutinWindowResizedEvent)
		ifFalse: [ ^ self ].

	BlGlutinHost
		hostForWindow: aWindow
		do: [ :aHostSpace | aGlutinWindowEvent accept: aHostSpace ]
]
