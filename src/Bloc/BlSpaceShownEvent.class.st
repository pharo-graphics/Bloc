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
	#instVars : [
		'space'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceShownEvent >> space [

	^ space
]

{ #category : #accessing }
BlSpaceShownEvent >> space: aBlSpace [

	space := aBlSpace
]
