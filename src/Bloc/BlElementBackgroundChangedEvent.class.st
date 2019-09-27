"
Is sent when element's background changes.

Example:

[[[
| element |

element := BlElement new.
element when: BlElementBackgroundChangedEvent do: [ self inform: 'Background changed' ].
element background: Color blue
]]]
"
Class {
	#name : #BlElementBackgroundChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlElementBackgroundChangedEvent >> sendTo: anObject [
	anObject elementBackgroundChanged: self
]
