"
Is sent when element's border changes.

Example:

[[[
| element |

element := BlElement new.
element when: BlElementBorderChangedEvent do: [ self inform: 'Border changed' ].
element border: (BlBorder paint: Color blue width: 20)
]]]
"
Class {
	#name : #BlElementBorderChangedEvent,
	#superclass : #BlElementEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlElementBorderChangedEvent >> sendTo: anObject [
	anObject elementBorderChanged: self
]
