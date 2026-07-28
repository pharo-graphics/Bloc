"
I am a host that lives in a Morphic World's UI thread and uses stepping mechanism to pulse the universe
"
Class {
	#name : #BlMorphicSteppingHost,
	#superclass : #BlHost,
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost >> delete [
	"Required to be polymorphic with Morph.
	See: https://github.com/pharo-graphics/Bloc/issues/785"

	^ self stop
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost >> isRunning [

	^ self currentWorld isStepping: self
]

{ #category : #'instance creation' }
BlMorphicSteppingHost >> newHostSpaceFor: aSpace [

	^ self subclassResponsibility
]

{ #category : #'private - stepping' }
BlMorphicSteppingHost >> shouldGetStepsFrom: aWorld [

	^ true
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost >> start [

	BlPulseLoopRequired value ifFalse: [ ^ self ].

	self currentWorld
		startStepping: self
		at: Time millisecondClockValue
		selector: #step
		arguments: nil
		stepTime: 0
]

{ #category : #'private - stepping' }
BlMorphicSteppingHost >> step [

	[ self universe pulse ]
		on: Exception
		do: [ :e |
			self start.
			e pass ]
]

{ #category : #'api - lifecycle' }
BlMorphicSteppingHost >> stop [

	self currentWorld stopStepping: self
]

{ #category : #'api - ui process' }
BlMorphicSteppingHost >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"

	UIManager default uiProcess ifNotNil: aBlock
]

{ #category : #'host - testing' }
BlMorphicSteppingHost >> waitUntil: aBlock timeout: aTimeoutBlock onCompletion: completionBlock onTimeout: timeoutBlock [
	MorphicUIManager uiProcess == Processor activeProcess
		ifTrue: [
			[ aBlock value ] whileFalse: [
				aTimeoutBlock value ifTrue: [ ^ timeoutBlock value ].
				self currentWorld doOneCycle.
				self universe pulse.
				(Delay forMilliseconds: 5) wait ].
			^ completionBlock value ]
		ifFalse: [
			^ super
				waitUntil: aBlock
				timeout: aTimeoutBlock
				onCompletion: completionBlock
				onTimeout: timeoutBlock ]
]
