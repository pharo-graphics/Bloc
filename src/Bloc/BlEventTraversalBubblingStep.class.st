"
The event is propagating back up through the target's ancestors in reverse order, starting with the parent, and eventually reaching the containing Root.

This is known as bubbling, and occurs only if BlEvent>>#canBePropagated is true. Event listeners registered for this phase are triggered during this process.

"
Class {
	#name : #BlEventTraversalBubblingStep,
	#superclass : #BlEventTraversalStep,
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlEventTraversalBubblingStep >> type [
	<return: #String>
	
	^ 'Bubbling'
]
