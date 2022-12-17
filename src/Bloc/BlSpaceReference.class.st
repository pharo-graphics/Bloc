"
# Space reference
Each element references a space in the scene graph in which that element is located. It is important for the {{gtClass:BlElement}} to know when it is added and removed from the scene graph e.g. {{gtClass:BlSpace}}, otherwise it would not be possible to clean up the custom external state. In addition to that an element should keep track of its attachment state which is described in this document.
## Attachment states
There are essential attachment states: `attached`, `detached` and `none (null)`. 
#### Attached
An element is called `attached` then and only then when it is a root element of the space or it is a child of an `attached` element. {{gtClass:BlAttachedSpaceReference}} represents an attached space reference.
#### Detached
An element is called `detached` then and only then when it or any of its parents is temporarily detached from the graph scene while it was `attached`. {{gtClass:BlDetachedSpaceReference}} represents a detached space reference.
#### Removed
An element is called `removed` then and only then when it or any of its parents is neither an `attached` or `detached` element. {{gtClass:BlNullSpaceReference}} represents a removed space reference.

## Events
When the attachment state of an element is changed from `removed` to `attached` a {{gtClass:BlElementAddedToSceneGraphEvent}} is dispatched.

"
Class {
	#name : #BlSpaceReference,
	#superclass : #Object,
	#category : #'Bloc-Space'
}

{ #category : #testing }
BlSpaceReference >> isAttachedToSceneGraph [
	^ false
]

{ #category : #testing }
BlSpaceReference >> isDetachedFromSceneGraph [
	^ false
]

{ #category : #testing }
BlSpaceReference >> isNull [
	^ false
]

{ #category : #'text input' }
BlSpaceReference >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	self spaceDo: [:sp | ^sp isTextInputActive].
	^ false
]

{ #category : #enumerating }
BlSpaceReference >> spaceDo: aBlock [
	"Evaluate a given block with a bloc space as an argument"
	
	
]

{ #category : #'text input' }
BlSpaceReference >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."
	self spaceDo: [ :sp | sp startTextInput ]

]

{ #category : #'text input' }
BlSpaceReference >> startTextInputAtRectangle: aRectangle [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."
	self spaceDo: [ :sp | sp startTextInputAtRectangle: aRectangle ]

]

{ #category : #'text input' }
BlSpaceReference >> stopTextInput [
	"Stop receiving any text input events"
	self spaceDo: [ :sp | sp stopTextInput ]

]
