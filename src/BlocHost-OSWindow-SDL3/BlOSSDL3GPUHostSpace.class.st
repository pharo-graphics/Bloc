Class {
	#name : #BlOSSDL3GPUHostSpace,
	#superclass : #BlOSSDL3HostSpace,
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #initialization }
BlOSSDL3GPUHostSpace >> initializeRenderer [
	"Resize the backing Form and GPU texture when the window size or scale changes."

	super initializeRenderer.
	self isValid ifFalse: [ ^ self ].
	OSWindowRenderThread uniqueInstance critical: [
		osWindow renderer ifNotNil: [ :aRenderer | aRenderer resized ] ]
]

{ #category : #initialization }
BlOSSDL3GPUHostSpace >> initializeWindowRenderer [

	osWindow renderer: (BlOSSDL3GPURenderer for: osWindow backendWindow)
]

{ #category : #rendering }
BlOSSDL3GPUHostSpace >> lockSurfaceFor: logicalDamagedRectangle scaleFactor: scaleFactor during: aBlock [

	| form physicalDamagedRectangle |
	form := osWindow renderer form.
	(form isNil or: [ form width <= 0 or: [ form height <= 0 ] ]) ifTrue: [ ^ self ].

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
