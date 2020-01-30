"
I fire an ${class:BlElementAddedToSceneGraphEvent}$ on ${method:BlSceneInformingElement>>#onAddedToSceneGraph|label=#selector}$.
I fire an ${class:BlElementRemovedFromSceneGraphEvent}$ on ${method:BlSceneInformingElement>>#onRemovedFromSceneGraph|label=#selector}$.

I can be used if an object (model) needs to be informed when I am attached to a scene and when I am removed from a scene.

You can use ${class:BlElementAddedToSceneGraphEventHandler}$ and ${class:BlElementRemovedFromSceneGraphEventHandler}$ to perform specific actions.

"
Class {
	#name : #BlSceneInformingElement,
	#superclass : #BlElement,
	#category : #'Bloc-Basic'
}

{ #category : #'children accessing' }
BlSceneInformingElement >> child [
	<return: #BlElement>
	self 
		assert: [ self childrenCount = 1 ]
		description: [ 'Scene informing element must have only one child to use this method' ].
	^ self childAt: 1
]

{ #category : #'api - event handlers' }
BlSceneInformingElement >> onAddedToSceneDo: aBlock [
	self addEventHandler: (BlElementAddedToSceneGraphEventHandler new valuable: aBlock)
]

{ #category : #'hooks - children' }
BlSceneInformingElement >> onAddedToSceneGraph [
	| anEventHandler |
	super onAddedToSceneGraph.
	anEventHandler := nil.
	anEventHandler := BlEventHandler on: BlSpaceClosedEvent do: [ :anEvent |
		self fireEvent: BlElementRemovedFromSceneGraphEvent new.
		anEvent space removeEventHandler: anEventHandler ].
	self fireEvent: (BlElementAddedToSceneGraphEvent new element: self).
]

{ #category : #'api - event handlers' }
BlSceneInformingElement >> onRemovedFromSceneDo: aBlock [
	self addEventHandler: (BlElementRemovedFromSceneGraphEventHandler new valuable: aBlock)
]

{ #category : #'hooks - children' }
BlSceneInformingElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self fireEvent: (BlElementRemovedFromSceneGraphEvent new element: self).
]
