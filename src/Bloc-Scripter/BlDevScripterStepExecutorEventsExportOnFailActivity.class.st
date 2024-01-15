Class {
	#name : #BlDevScripterStepExecutorEventsExportOnFailActivity,
	#superclass : #BlDevScripterStepExecutorStepActivity,
	#category : #'Bloc-Scripter-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorEventsExportOnFailActivity >> dumpEvents: aCollectionOfEvents in: aFileReference [
	aFileReference writeStreamDo: [ :aStream |
		| theExportedEvents |

		theExportedEvents := aCollectionOfEvents asArray
			collect: [ :eachEvent | eachEvent asDictionaryForExport ].
		
		aStream
				nextPutAll: (STONJSON toStringPretty: theExportedEvents) ]
]

{ #category : #execution }
BlDevScripterStepExecutorEventsExportOnFailActivity >> executePostPlayOnStep: aStep executor: anExecutor [
	aStep state = BlDevScripterStepState success
		ifTrue: [ ^ self ].
		
	aStep isRootStep
		ifTrue: [ ^ self ].

	self class debugFileNameFor: aStep do: [ :aDirectory :aFileName |
		aDirectory ensureCreateDirectory.
	
		self
			dumpEvents: anExecutor scripter events
			in: (aDirectory / (aFileName, '-events-all.txt')).

		self
			dumpEvents: (anExecutor scripter events select: [ :eachEvent | eachEvent isUIEvent ])
			in: (aDirectory / (aFileName, '-events-ui.txt')). ]
]
