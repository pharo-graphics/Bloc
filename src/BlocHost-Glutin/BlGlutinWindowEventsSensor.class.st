Class {
	#name : #BlGlutinWindowEventsSensor,
	#superclass : #GlutinWindowEventsSensor,
	#category : #'BlocHost-Glutin'
}

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processGlutinEvent: aGlutinWindowEvent forWindow: aWindow [
	BlGlutinHost
		hostForWindow: aWindow
		do: [ :aHostSpace | aGlutinWindowEvent accept: aHostSpace ]
]
