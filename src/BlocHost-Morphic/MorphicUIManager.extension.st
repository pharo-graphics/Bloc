Extension { #name : #MorphicUIManager }

{ #category : #'*BlocHost-Morphic' }
MorphicUIManager >> spawnNewProcess [
	| activeProcess |
	
	"In case the current process is attached to a Bloc universe, stop pulsation to allow the new UI process to step.
	This assumes that the current process is the UI process and will be interrupted. "
	activeProcess := Processor activeProcess.
	BlParallelUniverse all
		detect: [ :eachUniverse |
			| isUIProcess |
			isUIProcess := false.
			eachUniverse hostClass
				uiProcessDo: [ :eachUIProcess | isUIProcess := eachUIProcess == activeProcess ].
			isUIProcess ]
		ifFound: [ :aUniverse | 
			aUniverse requestStopPulsation ]
		ifNone: [  ].
	
	UIProcess := [
		MorphicRenderLoop new doOneCycleWhile: [ true ]
	] newProcess priority: Processor userSchedulingPriority.
	UIProcess name: 'Morphic UI Process'.
	UIProcess resume
]
