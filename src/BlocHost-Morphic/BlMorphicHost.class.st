"
I am a host that allows users to embed Bloc spaces inside of arbitrary morphs.
It is required to provide set a ==containerMorph== where bloc space will be embedded.

The main difference between me and BlMorphicWindowHost is the fact that I don't support window-specific properties like #borderless, #minimized, #maximized etc.

Because of Morphic limitations it is not possible to send an event when space is opened in the World.

Example:

[[[
morph := Morph new.
""container morph could also have #spaceFill resizing""
morph extent: 700@700.
""set layout policy to container morph in order for bloc space to fill space""
morph layoutPolicy: TableLayout new.

host := BlMorphicHost new.
host containerMorph: morph.

space := BlSpace new.
space host: host.
space show
]]]
"
Class {
	#name : #BlMorphicHost,
	#superclass : #BlHost,
	#instVars : [
		'containerMorph'
	],
	#category : #'BlocHost-Morphic-Host - Morph'
}

{ #category : #'api - ui process' }
BlMorphicHost class >> forceResumeOfUIProcess: aProcess [	
	MorphicUIManager classVarNamed: #UIProcess put: aProcess.
	aProcess resume
]

{ #category : #'api - ui process' }
BlMorphicHost class >> forceStartNewUIProcess [
	UIManager default spawnNewProcess
]

{ #category : #testing }
BlMorphicHost class >> isSupported [
	"I can not be used as one of the default Bloc host because I require users to provide containerMorph"
	^ false
]

{ #category : #testing }
BlMorphicHost class >> label [
	^ 'Morphic - Embedded'
]

{ #category : #testing }
BlMorphicHost class >> priority [
	"I have the lowest possible priority (I am also not supported)"
	<return: #Number>

	^ Float infinity
]

{ #category : #pulse }
BlMorphicHost class >> pulse [
	(BlParallelUniverse forHost: self) pulse
]

{ #category : #asserting }
BlMorphicHost class >> shouldGetStepsFrom: aWorld [
	^ true
]

{ #category : #'api - ui process' }
BlMorphicHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	UIManager default uiProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlMorphicHost >> containerMorph [
	<return: #Morph>

	^ containerMorph
]

{ #category : #accessing }
BlMorphicHost >> containerMorph: aMorph [
	containerMorph := aMorph
]

{ #category : #'host - api' }
BlMorphicHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"
	| aMorph aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].

	aMorph := self createMorphFor: aSpace.

	aHostSpace := BlMorphicHostSpace new spaceHostMorph: aMorph.
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlMorphicHost >> createMorphFor: aSpace [
	| aMorph |

	aMorph := BlMorphicSpaceHostMorph new.
	aMorph color: Color transparent.
	aMorph extent: aSpace extent.

	^ aMorph
]

{ #category : #'host - api' }
BlMorphicHost >> destroyHostSpaceFor: aSpace [

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host!' ].
	
	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #initialization }
BlMorphicHost >> initialize [
	super initialize.

	containerMorph := Morph new
]

{ #category : #'host - testing' }
BlMorphicHost >> isRunning [
	^ World isStepping: self class
]

{ #category : #'host - api' }
BlMorphicHost >> start [	
	World startStepping: self class at: Time millisecondClockValue selector: #pulse arguments: nil stepTime: nil
]

{ #category : #'host - api' }
BlMorphicHost >> stop [
	World stopStepping: self class
]

{ #category : #'host - testing' }
BlMorphicHost >> supportsBufferSurface [
	^ false
]

{ #category : #'host - testing' }
BlMorphicHost >> supportsFormSurface [
	^ true
]

{ #category : #'host - testing' }
BlMorphicHost >> supportsOpenGLSurface [
	^ false
]
