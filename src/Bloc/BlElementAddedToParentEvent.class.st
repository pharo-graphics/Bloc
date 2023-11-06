"
Is sent by an element after it is added to the parent.

Note: I am not sent when element is re-attached!

Example:

```
| child parent |

child := BlElement new.
child when: BlElementAddedToParentEvent do: [ self inform: 'Added to parent' ].

parent := BlElement new.
parent addChild: child.
```

"
Class {
	#name : 'BlElementAddedToParentEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementAddedToParentEvent class >> disableIn: anObject [
	anObject disableAddedToParent
]

{ #category : 'api - enable / disable' }
BlElementAddedToParentEvent class >> enableIn: anObject [
	anObject enableAddedToParent
]

{ #category : 'api - enable / disable' }
BlElementAddedToParentEvent class >> wantedIn: anObject [
	^ anObject wantsAddedToParent
]

{ #category : 'sending' }
BlElementAddedToParentEvent >> sendTo: anObject [
	anObject elementAddedToParentEvent: self
]
