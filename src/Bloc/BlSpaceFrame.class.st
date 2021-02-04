"
! Frame model

I represent one frame in a space. There are usually 60 frames per second, which means that ideally a frame should take less than 16ms to go through all phases.

My phases are:
- event handling
- scheduled tasks processing / animation
- layout
- rendering
- idle

I know my currentPhase which is one of the registered phases.

The list of default phases is initialized in ${method:BlSpaceFrame>>#initializePhases}$
"
Class {
	#name : #BlSpaceFrame,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'id',
		'phases',
		'currentPhaseLink'
	],
	#category : #'Bloc-Space - Frame'
}

{ #category : #adding }
BlSpaceFrame >> addPhase: aFramePhase [
	self
		assert: [ aFramePhase isNotNil ]
		description: [ 'Frame phase must not be nil' ].

	self phases add: aFramePhase
]

{ #category : #adding }
BlSpaceFrame >> addPhases: aCollectonOfPhases [
	aCollectonOfPhases do: [ :aFramePhase | self addPhase: aFramePhase ]
]

{ #category : #accessing }
BlSpaceFrame >> currentPhase [
	<return: #BlSpaceFramePhase>

	self
		assert: [ currentPhaseLink isNotNil ]
		description: [ 'Current phase must not be nil' ].

	^ currentPhaseLink value
]

{ #category : #testing }
BlSpaceFrame >> hasNextPhase [
	<return: #Boolean>

	^ currentPhaseLink nextLink isNotNil
]

{ #category : #accessing }
BlSpaceFrame >> id [
	"Return the frame id, which is a linearly increasing counter of frames"
	<return: #Number>
	
	^ id
]

{ #category : #private }
BlSpaceFrame >> incrementFrameId [
	id := id + 1
]

{ #category : #initialization }
BlSpaceFrame >> initialize [
	super initialize.
	
	id := 0.
	phases := LinkedList new.
	self initializePhases.
	currentPhaseLink := phases firstLink
]

{ #category : #initialization }
BlSpaceFrame >> initializePhases [
	self addPhases: { 
		BlSpaceFrameIdlePhase new.
		BlSpaceFrameHostValidationPhase new.
		BlSpaceFrameEventPhase new.
		BlSpaceFrameTaskPhase new.
		BlSpaceFrameStylePhase new.
		BlSpaceFramePropertiesPhase new.
		BlSpaceFrameDrawingValidationPhase new.
		BlSpaceFrameLayoutPhase new.
		BlSpaceFrameDrawingPhase new }
]

{ #category : #testing }
BlSpaceFrame >> isAtFirstPhase [
	<return: #Boolean>
	
	^ currentPhaseLink == phases firstLink
]

{ #category : #accessing }
BlSpaceFrame >> nextPhase [
	"Return the next frame after the current one"
	<return: #BlSpaceFramePhase>
	
	^ self nextPhaseLink value
]

{ #category : #private }
BlSpaceFrame >> nextPhaseLink [
	"Return the link with a next frame after the current one"
	<return: #Link>

	^ self hasNextPhase
		ifTrue: [ currentPhaseLink nextLink ]
		ifFalse: [ phases firstLink ]
]

{ #category : #accessing }
BlSpaceFrame >> phases [
	"Return a collection of all phases"
	<return: #Collection of: #BlSpaceFramePhase>

	^ phases
]

{ #category : #running }
BlSpaceFrame >> runCurrentPhaseOn: aSpace [
	aSpace telemetry
		timeSync: self currentPhase name
		during: [ self currentPhase runOn: aSpace ]
]

{ #category : #running }
BlSpaceFrame >> runOn: aSpace [
	self incrementFrameId.
	self runCurrentPhaseOn: aSpace.

	[ self hasNextPhase ] whileTrue: [
		self switchToNextPhase.
		self runCurrentPhaseOn: aSpace ].

	"move back to the first phase"
	self switchToNextPhase
]

{ #category : #running }
BlSpaceFrame >> switchToNextPhase [
	"Switch to the next phase"

	currentPhaseLink := self nextPhaseLink
]
