"
I'm a TaskIt service associated with a Bloc space.
"
Class {
	#name : #TKTBlSpaceService,
	#superclass : #TKTService,
	#instVars : [
		'space',
		'actionBlock'
	],
	#category : #'Bloc-Taskit-Objects'
}

{ #category : #examples }
TKTBlSpaceService class >> example1 [

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

{ #category : #'instance creation' }
TKTBlSpaceService class >> on: aBlSpace [
	
	^ self basicNew
		initializeOn: aBlSpace;
		yourself
]

{ #category : #initialization }
TKTBlSpaceService >> initializeOn: aBlSpace [ 

	self initialize.
	
	space := aBlSpace
]

{ #category : #accessing }
TKTBlSpaceService >> name [

	^ '{1}/{2}' format: { space. self identityHash }
]

{ #category : #accessing }
TKTBlSpaceService >> step: aBlockClosure [

	actionBlock := aBlockClosure
]

{ #category : #stepping }
TKTBlSpaceService >> stepService [

	space enqueueTask:
		(BlTaskAction new
			action: actionBlock;
			yourself)
]
