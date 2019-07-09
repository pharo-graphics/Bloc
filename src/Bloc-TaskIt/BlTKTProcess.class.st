Class {
	#name : #BlTKTProcess,
	#superclass : #TKTProcess,
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #private }
BlTKTProcess >> privateCreatePharoProcess [
	"Return an instance of TKTConfiguration process which is usually Process."
	<return: #Process>
	super privateCreatePharoProcess.
	process name: self name.
	^ process
]
