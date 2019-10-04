Class {
	#name : #BlGlutinWindowEventsSensor,
	#superclass : #GlutinWindowEventsSensor,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processGlutinEvent: aGlutinWindowEvent forWindow: aWindow [

	self
		assert: [ aWindow isValid ]
		description: [ 'Window must be valid' ].

	BlGlutinHost
		hostForWindow: aWindow
		do: [ :aHostSpace | aGlutinWindowEvent accept: aHostSpace ]
]
