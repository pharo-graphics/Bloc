Class {
	#name : 'BlSpaceFrame',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'id',
		'phases',
		'currentPhaseLink'
	],
	#category : 'Bloc-Space - Frame',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'adding' }
BlSpaceFrame >> addPhase: aFramePhase [

	self phases add: aFramePhase
]

{ #category : 'adding' }
BlSpaceFrame >> addPhase: aPhase before: otherPhase [

	self phases add: aPhase before: otherPhase
]

{ #category : 'adding' }
BlSpaceFrame >> addPhases: aCollectonOfPhases [
	aCollectonOfPhases do: [ :aFramePhase | self addPhase: aFramePhase ]
]

{ #category : 'accessing' }
BlSpaceFrame >> currentPhase [

	^ currentPhaseLink value
]

{ #category : 'enumerating' }
BlSpaceFrame >> detectPhase: aBlock [

	^ self phases detect: aBlock
]

{ #category : 'testing' }
BlSpaceFrame >> hasNextPhase [
	<return: #Boolean>

	^ currentPhaseLink nextLink isNotNil
]

{ #category : 'accessing' }
BlSpaceFrame >> id [
	"Return the frame id, which is a linearly increasing counter of frames"
	<return: #Number>
	
	^ id
]

{ #category : 'private' }
BlSpaceFrame >> incrementFrameId [
	id := id + 1
]

{ #category : 'initialization' }
BlSpaceFrame >> initialize [
	super initialize.
	
	id := 0.
	phases := LinkedList new.
	self initializePhases.
	currentPhaseLink := phases firstLink
]

{ #category : 'initialization' }
BlSpaceFrame >> initializePhases [

	self addPhases: { 
		BlSpaceFrameIdlePhase new.
		BlSpaceFrameHostValidationPhase new.
		BlSpaceFrameTaskPhase new. " animation as an example "
		BlSpaceFrameEventPhase new. " generate BlMouse events from host mouse event as an example "
		BlSpaceFrameDrawingValidationPhase new.
		BlSpaceFrameLayoutPhase new. " layouting all elements that requested layout "
		BlSpaceFrameDrawingPhase new " drawing invalidate elements  "}
]

{ #category : 'private' }
BlSpaceFrame >> nextPhaseLink [
	"Return the link with a next frame after the current one"
	<return: #Link>

	^ self hasNextPhase
		ifTrue: [ currentPhaseLink nextLink ]
		ifFalse: [ phases firstLink ]
]

{ #category : 'accessing' }
BlSpaceFrame >> phases [
	"Return a collection of all phases"
	<return: #Collection of: #BlSpaceFramePhase>

	^ phases
]

{ #category : 'removing' }
BlSpaceFrame >> removePhase: aFramePhase [

	self phases remove: aFramePhase ifAbsent: [ Error signal: 'Phase not found']
]

{ #category : 'running' }
BlSpaceFrame >> runCurrentPhaseOn: aSpace [

	self currentPhase runOn: aSpace
]

{ #category : 'running' }
BlSpaceFrame >> runOn: aSpace [
	self incrementFrameId.
	self runCurrentPhaseOn: aSpace.

	[ self hasNextPhase ] whileTrue: [
		self switchToNextPhase.
		self runCurrentPhaseOn: aSpace ].

	"move back to the first phase"
	self switchToNextPhase
]

{ #category : 'running' }
BlSpaceFrame >> switchToNextPhase [
	"Switch to the next phase"

	currentPhaseLink := self nextPhaseLink
]
