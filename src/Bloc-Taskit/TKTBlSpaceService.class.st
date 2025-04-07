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
