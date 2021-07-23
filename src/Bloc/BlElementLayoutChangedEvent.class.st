"
Is sent when element's layout changes.

Example:

```
| element |

element := BlElement new.
element when: BlElementLayoutChangedEvent do: [ self inform: 'Layout changed' ].
element layout: BlBasicLayout new
```

"
Class {
	#name : 'BlElementLayoutChangedEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementLayoutChangedEvent class >> enableIn: anObject [
	anObject enableLayoutChanged
]

{ #category : 'api - enable / disable' }
BlElementLayoutChangedEvent class >> wantedIn: anObject [
	^ anObject wantsLayoutChanged
]

{ #category : 'sending' }
BlElementLayoutChangedEvent >> sendTo: anObject [
	anObject elementLayoutChangedEvent: self
]
