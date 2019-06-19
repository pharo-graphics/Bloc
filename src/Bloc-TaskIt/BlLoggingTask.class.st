Class {
	#name : #BlLoggingTask,
	#superclass : #TKTGenericTask,
	#instVars : [
		'callingMethod'
	],
	#category : #'Bloc-TaskIt-Beacon'
}

{ #category : #'instance-creation' }
BlLoggingTask class >> valuable: aValuable [

	^self new 
		valuable: aValuable;
		callingMethod: thisContext sender sender method asRingDefinition;
		yourself
]

{ #category : #converting }
BlLoggingTask >> asLoggingTask [

	^self
]

{ #category : #accessing }
BlLoggingTask >> callingMethod [
	^ callingMethod
]

{ #category : #accessing }
BlLoggingTask >> callingMethod: anObject [
	callingMethod := anObject
]

{ #category : #executing }
BlLoggingTask >> value [ 

	| result |

	BlTaskItSignal emitValuable: valuable message: #startValue callingMethod: callingMethod.
	result := super value.
	BlTaskItSignal emitValuable: valuable message: #doneValue callingMethod: callingMethod.
	^result
]

{ #category : #executing }
BlLoggingTask >> value: aValue [

	| result |

	BlTaskItSignal emitValuable: valuable message: #startWithArg callingMethod: callingMethod.
	result := valuable value: aValue.
	BlTaskItSignal emitValuable: valuable message: #doneWithArg callingMethod: callingMethod.
	^result
]
