Class {
	#name : #BlTktProcess,
	#superclass : #TKTProcess,
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #private }
BlTktProcess >> privateCreatePharoProcess [
	"Return an instance of TKTConfiguration process which is usually Process."
	<return: #Process>
	process := BlProcess
		forContext: self createContext
		priority: self spawnPriority.
	process name: self name.
	process task: self task.
	^ process
]

{ #category : #private }
BlTktProcess >> task [
	^ self annotation: #task
]
