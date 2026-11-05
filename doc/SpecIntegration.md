# Using Bloc in a Spec Presenter

The package `Bloc-Spec2` provides a Spec presenter which shows a Bloc space inside a Spec window: `SpBlSpaceInMorphPresenter`. It is how the Bloc demo browser (`BlDemoPresenter`) shows the demos next to a list and a code pane, and it is the way to give a Bloc visualization a tool around it: a list, a toolbar, a code pane, buttons.

## 1. Add the canvas to a presenter

```smalltalk
SpPresenter subclass: #MyBrowser
	instanceVariableNames: 'canvas'
	...

MyBrowser >> initializePresenters
	canvas := self instantiate: SpBlSpaceInMorphPresenter

MyBrowser >> defaultLayout
	^ SpBoxLayout newTopToBottom
		add: canvas;
		yourself
```

The canvas gives access to a Bloc space with `canvas space`, and to its root with `canvas space root`. Add elements to the root as to the root of any space:

```smalltalk
MyBrowser >> show: anElement
	canvas space root
		removeChildren;
		addChild: anElement
```

## 2. Replacing the content

`removeChildren` followed by `addChild:` is the way to change what the canvas shows, for example when the selection of a list changes. The elements removed are detached from the space: handlers they installed on the root must be removed when they are detached (see [Graphical Patterns](GraphicalPatterns.md), "Install on attachment").

## 3. Testing a presenter

A presenter which contains a canvas can be created without opening a window (`MyBrowser new`), and its canvas space is usable: the elements added to `canvas space root` can be checked. Close the space of the canvas at the end of a test (`presenter canvas space close`).
