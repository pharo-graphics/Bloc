private - commands
processDataSourceCommandsAndSetAnimationFlags
	"Consumes data source commands and calculates which type of animations we want to run.
	Is sent in onMeasure and dispatchLayout.
	This method may process only the pre-layout state of updates or all of them."
	| animationTypeSupported |
	
	dataSourceChangedAfterLayout ifTrue: [
		dataSourceManager resetCommands.
		self markKnownElementsInvalid.
		layout onItemsChanged ].
	
	"Simple animations are a subset of advanced animations (which will cause a pre-layout step)
	If layout supports predictive animations, pre-process to decide if we want to run them"
	self predictiveItemAnimationsEnabled
		ifTrue: [ dataSourceManager preProcessCommands ]
		ifFalse: [ dataSourceManager consumeCommandsInOnePass ].

	animationTypeSupported := itemsAddedOrRemoved or: [ itemsChanged ].
	self state runSimpleAnimations: (firstLayoutComplete and: [
		(dataSourceChangedAfterLayout or: [ animationTypeSupported or: [ layout requestedSimpleAnimations ] ])
			and: [ dataSourceChangedAfterLayout not or: [ dataSource hasStableIds ] ] ]).
	
	self state runPredictiveAnimations: (self state willRunSimpleAnimations and: [
		animationTypeSupported and: [ dataSourceChangedAfterLayout not and: [ self predictiveItemAnimationsEnabled ] ] ])