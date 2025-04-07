"
I'm a TaskIt runner associated with a Bloc space.
"
Class {
	#name : #TKTBlSpaceRunner,
	#superclass : #TKTRunner,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Taskit-Objects'
}

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
