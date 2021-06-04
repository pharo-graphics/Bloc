"
# Understanding {{gtMethod:BlElement>>#onAddedToSceneGraph}}
As we know, {{gtClass:BlElement}} and {{gtClass:BlSpace}} play central roles in `Bloc`. When {{gtClass:BlElement}} is added to a {{gtClass:BlSpace}}, the space is referenced by the element with the help of {{gtClass:BlAttachedCachedSpaceReference}}, which denotes that the space is attached to the element.
## Scene graph
We define a `scene graph` is a combination of a tree of elements and a space which contains those elements.
## Attached element
An element is `attached` to the `scene graph` then and only then when that element or one of its parents is the root of a space. It is possible to test if an arbitrary element is attached to the scene graph by sending {{gtMethod:BlElement>>#isAttachedToSceneGraph}} message to that element. When an element is `attached to the scene graph`, {{gtMethod:BlElement>>#space}} returns a non-null instance of a {{gtClass:BlSpace}} to which that element is added.
## How to be notified when an element is attached to the scene graph?
There are two ways to be notified when an element is attached to the scene graph: an event {{gtClass:BlElementAddedToSceneGraphEvent}} and a hook (template) method {{gtMethod:BlElement>>#onAddedToSceneGraph}}.
Please note, that when overriding {{gtMethod:BlElement>>#onAddedToSceneGraph}} it is mandatory to delegate the hook method to the super class, otherwise the children would not be notified.
## When should I rely on the scene graph attachment hook?
There are very little cases when users should override {{gtMethod:BlElement>>#onAddedToSceneGraph}} or handle a corresponding event. This should only be used if the state or behavior of an element explicitly depends on the fact that it is a part of a `graph scene`. A good example of this would be subscribing to and unsubscribing from the {{gtClass:SystemAnnouncer}}. Another example is cache handling, when an element is attached to the scene graph, that element can potentially pre-load something from an external source and then release that cached resource then an element is removed from the scene graph. In addition to the mentioned examples, some elements may decide to add an event handler to the space when attached to the scene graph and then remove that event handler when an element is removed from the scene graph.
As you can see, the use-cases for the {{gtMethod:BlElement>>#onAddedToSceneGraph}} are parent independent and purely depent on the binary condition: attached or not attached to the scene graph.
## When to not rely on the scene graph attachment hook?
It is a mistake to rely on the `attached to the scene graph event` when the state of an element directly or indirectly depends on the state of its parents. Let's consider a font size and assume that the font size of a child depends on the font size of its parent. This situation may happen when the font size is defined in `em` units.
`1em` means that child should have the same font size as its parent, `0.5` means that the font size of a child is twice as small.
Everytime there is a change in the composition of the parents the font size should be recomputed. It should also be recomputed when the font size of any parent changes. What will happen when an element is transfered from one parent to the other within the same frame? It is very likely that the recomputation of the font size becomes inefficient and slow. A better solution would be to rely on {{gtClass:BlElementProperty}} which can be propagated to children ({{gtMethod:BlElementProperty>>#canPropagateToChildren}}).

See {{gtClass:BlElementPropertyExplanation}} for more information about properties.

"
Class {
	#name : #BlElementOnAddedToSceneGraphExplanation,
	#superclass : #Object,
	#category : #'Bloc-Docs-Element'
}
