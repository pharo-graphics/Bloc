"
I am sent by a space after it is removed from the space manager and its root element is removed from the scene graph.

However, the event is send before the host containing the space is stoped (if this is the last space).
This event should be used for implementing actions when a space is closed. 


Example:

```
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceClosedEvent
	do: [ self inform: 'Space closed' ].
space close
```

"
Class {
	#name : #BlSpaceClosedEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceClosedEvent >> sendTo: anObject [
	anObject spaceClosedEvent: self
]
