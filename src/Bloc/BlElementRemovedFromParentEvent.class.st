"
Is sent by an element after it is removed from the parent.

Note: I am not sent when element is detached!

Example:

```
| child parent |

child := BlElement new.
child when: BlElementRemovedEvent do: [ self inform: 'Removed from parent' ].

parent := BlElement new.
parent addChild: child.
parent removeChild: child
```

"
Class {
	#name : 'BlElementRemovedFromParentEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementRemovedFromParentEvent class >> disableIn: anObject [
	anObject disableRemovedFromParent
]

{ #category : 'api - enable / disable' }
BlElementRemovedFromParentEvent class >> enableIn: anObject [
	anObject enableRemovedFromParent
]

{ #category : 'api - enable / disable' }
BlElementRemovedFromParentEvent class >> wantedIn: anObject [
	^ anObject wantsRemovedFromParent
]

{ #category : 'sending' }
BlElementRemovedFromParentEvent >> sendTo: anObject [
	anObject elementRemovedFromParentEvent: self
]
