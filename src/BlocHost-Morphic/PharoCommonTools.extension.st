Extension { #name : #PharoCommonTools }

{ #category : #'*BlocHost-Morphic' }
PharoCommonTools >> emergencyDebugger [
	^ tools
		at: #emergencyDebugger
		ifAbsent: [ Transcripter ]
]
