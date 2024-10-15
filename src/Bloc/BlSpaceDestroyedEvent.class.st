"
I am an event raised when all normal events for closing a space have been completed.

This event is used by the debugger to stop the UI process so it should be used with case. For reacting to the closing of a space `BlSpaceClosedEvent` should be used instead.

"
Class {
	#name : #BlSpaceDestroyedEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}
