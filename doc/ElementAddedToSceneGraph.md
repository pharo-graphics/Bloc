# Understanding `BlElement >> #onAddedToSceneGraph`

`BlElement` and `BlSpace` play central roles in Bloc. When a `BlElement` is added to a `BlSpace`, the space is referenced by the element with the help of `BlAttachedCachedSpaceReference`, which records that the space is attached to the element.

## Scene Graph

A scene graph is the combination of an element tree and the space that displays those elements.

### Attached Elements

An element is attached to the scene graph if and only if it is the root of a space or a descendant of it. You can test if an element is attached by sending `BlElement >> #isAttachedToSceneGraph`. When an element is attached, `BlElement >> #space` answers the `BlSpace` instance to which it belongs.

### How to be notified when an element is attached to the scene graph?

There are two ways to be notified when an element is attached to the scene graph:
- Handling the event `BlElementAddedToSceneGraphEvent`.
- Overriding the hook method `BlElement >> #onAddedToSceneGraph`.

> [!IMPORTANT]
> When overriding `BlElement >> #onAddedToSceneGraph`, you must send `super onAddedToSceneGraph`; otherwise, descendant elements will not be notified.

### When should you rely on the scene graph attachment hook?

There are very few cases where you need to override `BlElement >> #onAddedToSceneGraph` or handle its event. This hook should only be used if the state or behavior of an element explicitly depends on whether it is part of a live scene graph:

- **System Announcements:** Subscribing to and unsubscribing from `SystemAnnouncer`.
- **Resource Caching:** Pre-loading an external cached resource when attached, and releasing it when removed from the scene graph.
- **Space-Level Event Handlers:** Adding an event handler to the space upon attachment, and removing it upon detachment.

Use cases for `BlElement >> #onAddedToSceneGraph` are parent-independent and depend strictly on the binary state: attached or detached from a space.

### When not to rely on the scene graph attachment hook

Do not rely on the attachment hook when the state of an element depends on the state of its parent elements (for example, cascading font sizes in em units where a child element's size depends on its parent's size).

Every time the hierarchy composition changes or a parent font size changes, the effective size must be recomputed. If an element is transferred from one parent to another within the same frame, recomputing via attachment hooks becomes inefficient and error-prone. A better solution is to rely on `BlElementProperty`, which propagates down the element tree cleanly (`BlElementProperty >> #canPropagateToChildren`).
