"
I am an event raised when all normal events for closing a space have been completed.

This event is used by the debugger to stop the UI process so it should be used with case. For reacting to the closing of a space {{gtClass:BlSpaceClosedEvent}} should be used instead.

"
Class {
	#name : 'BlSpaceDestroyedEvent',
	#superclass : 'BlSpaceEvent',
	#instVars : [
		'space'
	],
	#category : 'Bloc-Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceDestroyedEvent >> space [

	^ space
]

{ #category : 'accessing' }
BlSpaceDestroyedEvent >> space: aSpace [
	space := aSpace
]
