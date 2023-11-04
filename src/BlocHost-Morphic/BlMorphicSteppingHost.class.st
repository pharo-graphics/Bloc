"
I am a host that lives in a Morphic World's UI thread and uses stepping mechanism to pulse the universe
"
Class {
	#name : #BlMorphicSteppingHost,
	#superclass : #BlHost,
	#category : #'BlocHost-Morphic-Host - Common'
}

{ #category : #'api - ui process' }
BlMorphicSteppingHost class >> forceResumeOfUIProcess: aProcess [	
	MorphicUIManager classVarNamed: #UIProcess put: aProcess.
	aProcess resume
]

{ #category : #'api - ui process' }
BlMorphicSteppingHost class >> forceStartNewUIProcess [
	UIManager default spawnNewProcess
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost class >> isRunning [
	^ self currentWorld isStepping: self
]

{ #category : #'private - stepping' }
BlMorphicSteppingHost class >> shouldGetStepsFrom: aWorld [
	^ true
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost class >> start [	
	self currentWorld startStepping: self at: Time millisecondClockValue selector: #step arguments: nil stepTime: 0
]

{ #category : #'private - stepping' }
BlMorphicSteppingHost class >> step [
	(BlParallelUniverse forHost: self) pulse
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost class >> stop [
	self currentWorld stopStepping: self
]

{ #category : #'api - ui process' }
BlMorphicSteppingHost class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	UIManager default uiProcess ifNotNil: aBlock
]

{ #category : #'host - testing' }
BlMorphicSteppingHost >> supportsFormSurface [

	^ true
]
