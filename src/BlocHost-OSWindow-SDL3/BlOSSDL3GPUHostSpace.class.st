Class {
	#name : #BlOSSDL3GPUHostSpace,
	#superclass : #BlOSSDL3HostSpace,
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #rendering }
BlOSSDL3GPUHostSpace >> lockSurfaceFor: logicalDamagedRectangle scaleFactor: scaleFactor during: aBlock [

	| form physicalDamagedRectangle |
	form := osWindow renderer form.
	form ifNil: [ ^ self ].

	physicalDamagedRectangle :=
		((logicalDamagedRectangle
			intersect: (0@0 extent: osWindow extent)
			ifNone: [ ^ self ]) scaleBy: scaleFactor) asExpandedRectangle.

	"Pass the logicalDamagedRectangle for surgical clipping in Cairo.
	 physicalRectangle remains the full Form extent to match the backing surface."
	renderer
		renderWith: aBlock
		pixels: form bits
		stride: form width * 4
		physicalRectangle: (0@0 extent: form extent)
		logicalRectangle: logicalDamagedRectangle.

	osWindow renderer updateRectangle: physicalDamagedRectangle
]
