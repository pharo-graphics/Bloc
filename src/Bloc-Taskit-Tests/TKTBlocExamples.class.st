Class {
	#name : #TKTBlocExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Taskit-Tests'
}

{ #category : #examples }
TKTBlocExamples >> runnerExample [
	<sampleInstance>
"  This is equivalent to:
	space
		enqueueTask:
			(BlRepeatedTaskAction new
				delay: 200 milliSeconds;
				action: [ space root background: Color random ];
				yourself)."

	| space runner |
	space := BlSpace new.
	space
		extent: 100@100;
		show.

	runner := TKTBlSpaceRunner on: space.

	[	17 timesRepeat: [
			runner schedule: [
				space root background: Color random ] asTask.
			200 milliSeconds wait ] ] fork.

	^ space
]

{ #category : #examples }
TKTBlocExamples >> serviceExample [
	<sampleInstance>
	"This example is equivalent to:
	space
		enqueueTask:
			(BlRepeatedTaskAction new
				delay: 100 milliSeconds;
				action: [ space root background: Color random ];
				yourself)."

	| space service |
	space := BlSpace new.
	space
		extent: 100@100;
		show.

	service := TKTBlSpaceService on: space.
	service step: [ space root background: Color random ].
	service stepDelay: 100 milliSeconds.
	service start.

	[	2 seconds wait.
		service stop waitForCompletion: 1 second ] fork.
	
	^ space
]
