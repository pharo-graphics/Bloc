Class {
	#name : #BlLoggingTask,
	#superclass : #TKTGenericTask,
	#category : #'Bloc-TaskIt-Beacon'
}

{ #category : #converting }
BlLoggingTask >> asLoggingTask [

	^self
]

{ #category : #executing }
BlLoggingTask >> value [ 

	| result |

	BlTaskItSignal emitValuable: valuable message: #starting.
	result := super value.
	BlTaskItSignal emitValuable: valuable message: #done.
	^result
]
