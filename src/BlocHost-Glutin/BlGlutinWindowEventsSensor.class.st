Class {
	#name : #BlGlutinWindowEventsSensor,
	#superclass : #GlutinWindowEventsSensor,
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processCommonEvent: aGlutinCommonEvent forWindow: aGlutinWindow [

	self
		assert: [ aGlutinWindow isValid ]
		description: [ 'Window must be valid' ].

	BlGlutinHost
		hostForWindow: aGlutinWindow
		do: [ :aHostSpace | aGlutinCommonEvent accept: aHostSpace ]
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processDeviceEvent: aGlutinDeviceEvent forWindow: aGlutinWindow [

	self
		assert: [ aGlutinWindow isValid ]
		description: [ 'Window must be valid' ].

	BlGlutinHost
		hostForWindow: aGlutinWindow
		do: [ :aHostSpace | aGlutinDeviceEvent accept: aHostSpace ]
]

{ #category : #'event - handling' }
BlGlutinWindowEventsSensor >> processWindowEvent: aGlutinWindowEvent forWindow: aWindow [

	self
		assert: [ aWindow isValid ]
		description: [ 'Window must be valid' ].

	BlGlutinHost
		hostForWindow: aWindow
		do: [ :aHostSpace | aGlutinWindowEvent accept: aHostSpace ]
]
