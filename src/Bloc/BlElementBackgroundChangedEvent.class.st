"
Is sent when element's background changes.

Example:

```
| element |

element := BlElement new.
element when: BlElementBackgroundChangedEvent do: [ self inform: 'Background changed' ].
element background: Color blue
```

"
Class {
	#name : 'BlElementBackgroundChangedEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementBackgroundChangedEvent class >> enableIn: anObject [
	anObject enableBackgroundChanged
]

{ #category : 'api - enable / disable' }
BlElementBackgroundChangedEvent class >> wantedIn: anObject [
	^ anObject wantsBackgroundChanged
]

{ #category : 'sending' }
BlElementBackgroundChangedEvent >> sendTo: anObject [
	anObject elementBackgroundChangedEvent: self
]
