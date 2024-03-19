Class {
	#name : #TKTBlSpaceRunner,
	#superclass : #TKTRunner,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Taskit-Objects'
}

{ #category : #examples }
TKTBlSpaceRunner class >> example1 [

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

{ #category : #'instance creation' }
TKTBlSpaceRunner class >> on: aBlSpace [
	
	^ self basicNew
		initializeOn: aBlSpace;
		yourself
]

{ #category : #initialization }
TKTBlSpaceRunner >> initializeOn: aBlSpace [ 

	self initialize.
	
	space := aBlSpace
]

{ #category : #schedulling }
TKTBlSpaceRunner >> scheduleTaskExecution: aTaskExecution [

	space enqueueTask:
		(BlTaskAction new
			action: [ self executeTask: aTaskExecution ];
			yourself)
]
