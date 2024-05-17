Class {
	#name : #TKTBlocExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Taskit-Tests'
}

{ #category : #examples }
TKTBlocExamples >> runnerExample [
	<sampleInstance>

	| space runner |
	space := BlSpace new.
	space
		extent: 100@100;
		show.

	runner := TKTBlSpaceRunner on: space.

	[	17 timesRepeat: [
			runner schedule: [
				space root background: Color random ] asTask.
			250 milliSeconds wait ].

		runner stop.
		space close ] fork

"  We kind of emulate this:
	space
		enqueueTask:
			(BlRepeatedTaskAction new
				delay: 250 milliSeconds;
				action: [ space root background: Color random ];
				yourself)."
]

{ #category : #examples }
TKTBlocExamples >> serviceExample [
	<sampleInstance>

	| space service |
	space := BlSpace new.
	space
		extent: 100@100;
		show.

	service := TKTBlSpaceService on: space.

	service step: [ space root background: Color random ].
	service stepDelay:	250 milliSeconds.
	service start.
	
	[  3 seconds wait.
		service stop.
		space close ] fork

"  We kind of emulate this:
	space
		enqueueTask:
			(BlRepeatedTaskAction new
				delay: 250 milliSeconds;
				action: [ space root background: Color random ];
				yourself)."
]
