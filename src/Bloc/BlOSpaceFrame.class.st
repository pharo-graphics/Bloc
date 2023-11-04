"
# Frame model

I represent one frame in a space. There are usually 60 frames per second, which means that ideally a frame should take less than 16ms to go through all phases.

My phases are:
- event handling
- scheduled tasks processing / animation
- layout
- rendering
- idle

I know my currentPhase which is one of the registered phases.

The list of default phases is initialized in {{gtMethod:BlSpaceFrame>>#initializePhases}}

"
Class {
	#name : 'BlOSpaceFrame',
	#superclass : 'BlSpaceFrame',
	#classTraits : 'TBlDebug classTrait',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'initialization' }
BlOSpaceFrame >> initializePhases [
	self addPhases: { 
		BlSpaceFrameIdlePhase new.
		BlSpaceFrameHostValidationPhase new.
		BlSpaceFrameTaskPhase new.
		BlSpaceFrameEventPhase new.
		BlSpaceFrameStylePhase new.
		BlSpaceFramePropertiesPhase new.
		BlSpaceFrameDrawingValidationPhase new.
		BlSpaceFrameLayoutPhase new.
		BlSpaceFrameDrawingPhase new }
]
