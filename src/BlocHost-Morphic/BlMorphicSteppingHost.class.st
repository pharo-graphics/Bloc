"
I am a host that lives in a Morphic World's UI thread and uses stepping mechanism to pulse the universe
"
Class {
	#name : #BlMorphicSteppingHost,
	#superclass : #BlHost,
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost class >> delete [
	"Required to be polymorphic with Morph.
	See: https://github.com/pharo-graphics/Bloc/issues/785"

	^ self stop
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

	self currentWorld
		startStepping: self
		at: Time millisecondClockValue
		selector: #step
		arguments: nil
		stepTime: 0
]

{ #category : #'private - stepping' }
BlMorphicSteppingHost class >> step [

	[ self universe pulse ]
		on: Exception
		do: [ :e |
			self start.
			e pass ]
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

{ #category : #'instance creation' }
BlMorphicSteppingHost >> newHostSpaceFor: aSpace [

	^ self subclassResponsibility
]

{ #category : #'host - testing' }
BlMorphicSteppingHost >> wait: aBlock timeout: aDuration onCompletion: completionBlock onTimeout: timeoutBlock [
	| deadline timeProvider |
	MorphicUIManager uiProcess == Processor activeProcess
		ifTrue: [
			timeProvider := self universe spaces
				ifNotEmpty: [ :theSpaces | theSpaces first time ]
				ifEmpty: [ BlTime real ].
			deadline := timeProvider now + aDuration.
			[ aBlock value ] whileTrue: [
				timeProvider now >= deadline ifTrue: [ ^ timeoutBlock value ].
				MorphicRenderLoop new doOneCycle.
				self universe pulse.
				(Delay forMilliseconds: 5) wait ].
			^ completionBlock value ]
		ifFalse: [
			^ super
				wait: aBlock
				timeout: aDuration
				onCompletion: completionBlock
				onTimeout: timeoutBlock ]
]
