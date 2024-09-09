"
Is sent when element's border changes.

Example:

```
| element |

element := BlElement new.
element when: BlElementBorderChangedEvent do: [ self inform: 'Border changed' ].
element border: (BlBorder paint: Color blue width: 20)
```

"
Class {
	#name : #BlElementBorderChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementBorderChangedEvent class >> disableIn: anObject [
	anObject disableBorderChanged
]

{ #category : #'api - enable / disable' }
BlElementBorderChangedEvent class >> enableIn: anObject [
	anObject enableBorderChanged
]

{ #category : #'api - enable / disable' }
BlElementBorderChangedEvent class >> wantedIn: anObject [
	^ anObject wantsBorderChanged
]
