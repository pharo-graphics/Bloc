"
I am an abstract background resizer.
My main responsibility is to adapt background to element's size.

My subclasses must implement adapt:to:
"
Class {
	#name : #BlBackgroundResizer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlBackgroundResizer class >> exact: anExtent [
	"Return an instance of exact background resizer for a given extent as a point.
	anExtent must not be nil"
	<return: #BlBackgroundResizer>
	
	^ BlBackgroundExactResizer new extent: anExtent
]

{ #category : #'instance creation' }
BlBackgroundResizer class >> match [
	"Return an instance of resizer that makes background be as big as owner element"
	<return: #BlBackgroundResizer>

	^ BlBackgroundMatchResizer uniqueInstance
]
