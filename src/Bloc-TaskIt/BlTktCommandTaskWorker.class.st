Class {
	#name : #BlTktCommandTaskWorker,
	#superclass : #TKTWorker,
	#traits : 'TBlDebug + TBlTktCommandTaskScheduler',
	#classTraits : 'TBlDebug classTrait + TBlTktCommandTaskScheduler classTrait',
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #'start-stop' }
BlTktCommandTaskWorker >> stopAfterTaskCompleted [
	"Stop after the current task has been completed"

	^process stopAfterTaskCompleted

]
