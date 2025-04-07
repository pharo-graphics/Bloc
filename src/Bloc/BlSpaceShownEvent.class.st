"
I am sent by a space after it is shown.

Example:

```
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceShownEvent
	do: [ :anEvent | self inform: 'Space shown: ', anEvent space asString ].
space show
```

"
Class {
	#name : #BlSpaceShownEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}
