Class {
	#name : #BlInfiniteChildrenUpdateRunnable,
	#superclass : #BlTask,
	#instVars : [
		'infiniteElement'
	],
	#category : #'Bloc-Infinite-Tasks'
}

{ #category : #'instance creation' }
BlInfiniteChildrenUpdateRunnable class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #initialization }
BlInfiniteChildrenUpdateRunnable >> initializeWith: anInfiniteElement [
	
	self
		assert: [ infiniteElement isNil ]
		description: [ 'I can be initialized only once!' ].

	infiniteElement := anInfiniteElement
]

{ #category : #'api - running' }
BlInfiniteChildrenUpdateRunnable >> run [

	(infiniteElement isFirstLayoutComplete not or: [
		infiniteElement isLayoutRequested ])
			"a layout request will happen, we should not do layout here."
			ifTrue: [ ^ self ].
	
	infiniteElement isAttached
		ifFalse: [ 
			"if we are not attached yet, mark us as requiring layout and skip"
			infiniteElement requestLayout.
			^ self ].
	
	"actually perform all necessary updates and trigger layout update"
	infiniteElement consumePendingDataSourceCommands
]
