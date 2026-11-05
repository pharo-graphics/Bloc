# Troubleshooting

Symptoms met when building on Bloc, with their usual explanation. Each entry points to the guide that explains the mechanism.

## An element exists but nothing is drawn

Check, in this order:

1. **Is the element in the space?** `element isAttachedToSceneGraph` must be `true`.
2. **Does it have a size?** An element with no size policy has an extent of `0 @ 0`. Give it an `extent:` or a `fitContent` policy. See [Layout and Constraints](LayoutAndConstraints.md).
3. **Is it clipped?** An element placed outside of the bounds of its parent is not drawn, because the parent clips its children. Try `parent clipChildren: false`. Nothing is drawn outside of the root of the space either: an element at a negative position is invisible. See [Graphical Patterns](GraphicalPatterns.md).
4. **Is the layout done?** Right after a change the bounds are the old ones: `space settle` first. See [Concurrency and Synchronization](2-ConcurrencyAndSynchronization.md).

## The extent is `0 @ 0` just after adding an element

The extent is computed by the layout phase of the pulse loop, not by `addChild:`. Wait for the space with `space settle`.

## A text is on one line and a strange character is drawn

Line feeds and carriage returns are not line breaks for a `BlTextElement`. See [Working with Text](Text.md).

## A text does not wrap

A `BlTextElement` does not wrap at a given width. See [Working with Text](Text.md).

## An element is not laid out, or `resizer` is not understood

The constraints of the element were replaced with `constraints:` by an object of a layout, for example `BlFrameLayoutConstraints new`. Use the facets (`constraints frame`, `constraints linear`) of the constraints of the element instead. See [Layout and Constraints](LayoutAndConstraints.md).

## A handler of the layout never stops

A handler of `BlElementLayoutComputedEvent` which changes the element each time requests a layout which sends the event again. Change something only when it differs from what is there. See [Layout and Constraints](LayoutAndConstraints.md).

## An error opens a debugger and the windows freeze

The pulse loop runs the events, the tasks, the layout and the rendering of all the spaces of a host in one process. An error in a handler, a task, a layout or a drawing is raised in that process: a debugger opens, and the pulse process stays suspended in it.

What we observed while it is open:

- the windows of the host do not update, and the other spaces of the same host stay unchanged;
- a `settle` sent from another process does not return, until it times out when you use `settleForDuration:`;
- an error in the rendering is raised inside the lock of the render thread (the stack shows `OSWindowRenderThread >> #critical:`), and the lock stays held while the debugger is open, which freezes the drawing of the other windows too;
- a space that you close in this state stays in the closing state.

To see which hosts are stuck, look at the pulse processes. A pulse process suspended in a debugger has `OupsDebuggerSystem >> #suspendDebuggedProcess:` as its top context:

```smalltalk
(Process allInstances select: [ :process | process name includesSubstring: 'Pulse' ])
	select: [ :process | process isSuspended ]
```

Each suspended pulse process has a debugger window open, and there can be several, one per host.

To recover:

1. Close the debugger.
2. If a window is still stuck, evaluate `Bloc closeSpaces`, which closes all the spaces of all the hosts, then close the remaining debuggers (several can have opened).
3. Fix the cause. The first lines of the stack are in the Bloc code, the first lines which belong to your project show where to look.

An error that you raise in your own process, such as an assertion in a test, does not do this: only the errors raised in the pulse process do. The headless host is not protected: a layout error left a space of the headless host suspended in the same way. See [Testing Interactions and Drawing](TestingInteractions.md) for the headless host.

## Every window is blank or has an extent of `0 @ 0` after I added an instance variable to a class of elements

Adding an instance variable (a slot) to a class whose instances are in open spaces gives these instances `nil` in the new slot. Their next layout or event raises an error in the pulse process, a debugger suspends it as described above, and the other windows of the same host stay frozen: the extents of new elements stay `0 @ 0`, `settle` times out, and the tests which follow fail for a reason which is not in their code.

Before looking at the new code, look for suspended pulse processes (see the code above) and read the stack of one: the first error is the one to fix. To recover:

1. Set the new slot on the live instances (`SomeElementClass allInstances do: [ :each | each instVarNamed: 'slot' put: value ]`), or close the spaces which hold them (`Bloc closeSpaces`).
2. Terminate the suspended pulse processes and close their debuggers.
3. Restart the host: `BlHeadlessHost default stop; start`.

When you work on a class of elements, close the windows of your tests before adding a slot to it.

## `BlAlreadyAddedAsChildError` when I add a child

`addChild:` raises it, with an empty message, when the element already has a parent, even when it is another parent. Remove the element first (`removeFromParent`, or `removeChildren` on the old parent). See [Layout and Constraints](LayoutAndConstraints.md).

## A tooltip or a pop-up blinks

It is under the mouse, so the mouse leaves the element it is for, which hides it, and enters the element again. Send `preventMeAndChildrenMouseEvents` to the pop-up. See [Overlays](Overlays.md).

## A click arrives at the end of a drag, or at the parent of the element I clicked

A press, moves and a release on the same element are a click, and a click arrives at the handlers of the parents of the element too. See [About Mouse Events](MouseEvent.md).

## A zoom or a pan is wrong when the window is not at the corner of the screen

The handler reads `screenPosition`, the position on the desktop. Use `position`, the position in the space. See [Graphical Patterns](GraphicalPatterns.md).

## `space pulse` is deprecated

`BlSpace >> #pulse` is deprecated: sent directly it causes concurrency races. Use `settle`, `settleForDuration:` or `deferAndSettle:`. See [Concurrency and Synchronization](2-ConcurrencyAndSynchronization.md).

## A test which opens a window fails on a machine without a display

Use the headless host. See [Testing Interactions and Drawing](TestingInteractions.md).
