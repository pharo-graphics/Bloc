Extension { #name : 'BlBaseAnimation' }

{ #category : '*Bloc-Extensions' }
BlBaseAnimation >> gtInspectorPropertiesIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastTable
		title: 'Properties';
		display: [ {
			'Duration' -> self duration humanReadablePrintString.
			'Delay' -> self delay humanReadablePrintString.
			'Loops' -> self loops.
			'Progress' -> self progress.
			'Repeats' -> self repeats.
			'Is started' -> self isStarted.
			'Is running' -> self isRunning.
			'Start time' -> (self isStarted ifTrue: [ self startTime ] ifFalse: [ 'unknown' ]).
			'Elapsed time' -> (self isStarted ifTrue: [ self elapsedTime humanReadablePrintString ] ifFalse: [ 'unknown' ]).
		} ];
		column: '' evaluated: '' width: 1; "empty column for left margin"
		column: 'Property' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]
