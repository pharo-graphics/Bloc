# Using Bloc in a Spec Presenter

The package `Bloc-Spec2` provides `SpBlocPresenter`, a Spec2 widget presenter that displays a `BlElement` inside a Spec window. It is how the Bloc demo browser (`BlDemoPresenter`) shows demos next to a tree and a code pane, and it is the way to give a Bloc visualization a Spec UI around it (lists, toolbars, code panes, buttons).

It works across Spec backends:
- On Morphic (the default), `SpMorphicBlocAdapter` embeds the element in a `BlSpace` hosted by `BlMorphicHost` and closes that space when the window closes.
- On Toplo (when `Spec-Toplo` is loaded), `SpToploBlocAdapter` embeds the element directly in the Toplo scene graph.

## 1. Add the presenter

```smalltalk
SpPresenter subclass: #MyBrowser
	instanceVariableNames: 'canvas'
	...

MyBrowser >> initializePresenters
	canvas := self instantiate: SpBlocPresenter

MyBrowser >> defaultLayout
	^ SpBoxLayout newTopToBottom
		add: canvas;
		yourself
```

## 2. Displaying and replacing an element

Assign the `BlElement` to show with `blocElement:`, or pass `nil` to clear the view:

```smalltalk
MyBrowser >> show: anElement
	canvas blocElement: anElement
```

Replacing the element detaches the previous element from the scene graph and attaches the new one. Handlers installed on the space upon attachment should be removed on detachment (see [Understanding Scene Graph Attachment](ElementAddedToSceneGraph.md) and [Graphical Patterns](GraphicalPatterns.md)).

To react when the displayed element changes, subscribe with `canvas whenBlocElementChangedDo: [ :newElement :oldElement | ... ]`.

## 3. Testing a presenter

Open the presenter, settle the element's space before asserting on layout or simulating events, and close the window when done:

```smalltalk
element := BlElement new extent: 100 @ 50; yourself.
presenter := SpBlocPresenter new blocElement: element; yourself.
window := presenter open.
space := element space.
space settle.
self assert: element extent equals: 100 @ 50.

window close.
space settle
```

> [!NOTE]
> `SpBlSpaceInMorphPresenter` is deprecated in favor of `SpBlocPresenter`.
