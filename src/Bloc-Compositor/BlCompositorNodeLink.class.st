"
I am a NodeLink, the elementary part of a CompositorNodeChain.

I hold a value, as well as a link to my successor (nextLink) and to my predecessor (previousLink) - both can be nil.
"
Class {
	#name : #BlCompositorNodeLink,
	#superclass : #DoubleLink,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : 'Bloc-Compositor'
}

{ #category : #'event management accessing' }
BlCompositorNodeLink >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ self node element eventDispatcher
]

{ #category : #'event management accessing' }
BlCompositorNodeLink >> nextEventTarget [
	"Return next event target that should be contained in dispatch chain or nil if none.
	Note: returned object must use TBlEventTarget trait!
	Default implementation returns nothing, override me in order to dispatch
	event along your custom object chain"
	<return: #TBlEventTarget or: nil>

	^ self nextLink
]

{ #category : #accessing }
BlCompositorNodeLink >> node [
	<return: #BlCompositorNode>

	^ self value
]
