"
! Frame model

I represent one space frame. There are usually 60 frames per seconds, which means that ideally frame should take less than 16ms to go through all phases.

The frame consists of three important phases
- event handling
- scheduled tasks processing / animation
- layout
- rendering
-idle

I know my currentPhase which is one of the registered phases.

The list of default phases is initialized in ${method:BlSpaceFrame>>#initializePhases}$
"
Class {
	#name : #BlSpaceFrame,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
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

{ #category : #'as yet unclassified' }
BlSpaceFrame >> gtInspectorPhasesIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	
	^ aComposite fastList
		title: 'Phases';
		display: [ self phases ];
		format: [ :each | each = self currentPhase
			ifTrue: [ each name asText allBold ]
			ifFalse: [ each name ] ]
]

{ #category : #testing }
BlSpaceFrame >> hasNextPhase [
	<return: #Boolean>

	^ currentPhaseLink nextLink isNotNil
]

{ #category : #initialization }
BlSpaceFrame >> initialize [
	super initialize.

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
		BlSpaceFrameLayoutPhase new.
		BlSpaceFrameDrawingValidationPhase new.
		BlSpaceFrameDrawingPhase new }
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
	self currentPhase runOn: aSpace
]

{ #category : #running }
BlSpaceFrame >> runOn: aSpace [

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
