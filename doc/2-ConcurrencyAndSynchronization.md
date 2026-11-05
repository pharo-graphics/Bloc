# Concurrency and Synchronization in Bloc

## 1. The Bloc Concurrency Model

In Bloc, visual components are represented by **`BlElement`** instances organized in a scene tree. An element tree belongs to a **`BlSpace`**, which represents the window or display surface holding the root element.

Each space is attached to a **`BlHost`** (such as SDL3, OSWindow, Morphic, or Headless), which bridges the space with the operating system or windowing backend. The host runs a dedicated Pharo Process executing a continuous **pulse loop**.

During each pulse cycle, the host executes the space frame phases sequentially:
1. **Host Validation & Lifecycle:** Open, attach, and close host windows.
2. **Events:** Dispatch pending mouse, keyboard, and window events from `eventQueue`.
3. **Tasks:** Execute animations and scheduled **`BlTask`** instances (including deferred actions) from `taskQueue`.
4. **Layout:** Measure elements and compute geometry bounds across the scene graph.
5. **Render:** Draw damaged visual areas onto the host surface.
6. **Pulse Notification:** Signal pulse semaphores to notify waiting processes that the frame has completed.

*(Higher-level widget frameworks like Toplo can plug custom phases into this pipeline, for example to install skins or apply widget states before the layout phase).*

Because the space pulse loop runs in its own Pharo Process, any other code you execute runs concurrently with it:
- When you evaluate code in the Playground, run a test in SUnit, or fetch data from a background worker, your code runs on a **different process** than the space pulse loop.
- Modifying elements directly while the pulse loop is measuring or drawing them causes race conditions.
- To safely interact with attached elements from another process, you schedule work via **`BlTask`** (using `space defer:`, `space deferAndSettle:`, or `space enqueueTask:`).

---

## 2. Common surprises when starting with Bloc

### 1. Opening a space: why `space isOpened` answers `false`
```smalltalk
space := BlSpace new.
space open.
space isOpened. ">>> false!"
```
Sending `#open` tells the host to open the space, but the actual window attachment is executed by the host pulse loop. If you check `#isOpened` immediately on the next line, the pulse loop has not run its opening step yet.

### 2. Setting a constraint vs reading geometry bounds
```smalltalk
space root addChild: (box := BlElement new).
box width: 100.
box width. ">>> 0!"
```
Sending `box width: 100` records a *layout constraint*. The actual geometry width is computed during the layout phase of the pulse loop. Sending `box width` right away reads the *current calculated bounds*, which have not been computed yet.

### 3. Background workers modifying the UI
If a background process (like a socket, worker thread, or HTTP request) modifies element properties directly while the pulse process is running layout or rendering, you get data races and corrupted geometry.

---

## 3. The Settle and Defer API

To coordinate your code with the space pulse loop, `BlSpace` provides synchronization methods:

```smalltalk
"In Playground, tests, or scripts:"
space := BlSpace new.
space open.
space settle. "Waits until window opening and initial layout reach equilibrium"
self assert: space isOpened.

"Safely run a change on the pulse process and wait for layout to finish:"
space deferAndSettle: [ box width: 100 ].
self assert: box width equals: 100.
```

### The core messages:

* **`space settle`**: Blocks the active process until the space reaches equilibrium (no pending events, tasks, or layout requests). It automatically requests a pulse (`self requestPulse`) before waiting, so an idle space wakes up and runs a frame.
* **`space settleFor: aTimeoutValuable`**: Waits until the space settles, or until `aTimeoutValuable` evaluates to `true`. Returns `true` if settled, or `false` on timeout.
* **`space settleForDuration: aDuration`**: Bounded settle with a timeout duration (e.g., `100 milliSeconds`).
* **`space deferAndSettle: aBlock`**: Schedules `aBlock` to run on the space pulse loop and blocks the active process until all resulting tasks and layout passes have settled. This is the main idiom for unit tests.
* **`space defer: aBlock`**: Thread-safe asynchronous dispatch onto the pulse process without waiting. Use this from background workers when receiving external data.
  > [!NOTE]
  > Always send `#defer:` to an opened `BlSpace` (or `#enqueueTask:` to a `BlElement`), never to a `BlHost` (`BlHost >> #defer:` is deprecated).
* **`space isSettled`**: A non-blocking query answering whether the space has reached equilibrium across all its frame phases.

### Running something later on the pulse loop

A block which has to run after a delay, on the pulse process and not in a process of your own, is a `BlDelayedTaskAction`:

```smalltalk
task := BlDelayedTaskAction new
	delay: 300 milliSeconds;
	action: [ fired := true ];
	yourself.
task element: space root.
task startOrRestart.
space settleForDuration: 100 milliSeconds.
fired. ">>> false"
space settleForDuration: 500 milliSeconds.
fired. ">>> true"
```

`element:` must come before `startOrRestart`, which enqueues the task on the space of the element, and sending `startOrRestart` again restarts the delay (a tooltip which waits for the mouse to stay). `stop` cancels it: a task stopped before its delay never runs. The action runs on the pulse process, so it can change attached elements without `defer:`, and it must not wait for the space. It works on the headless host. See [Overlays](Overlays.md) for a tooltip built with it.

---

## 4. Preventing deadlocks: `#denyPulseProcess`

What happens if you send `space settle` or `space deferAndSettle:` from *inside* an event handler or task running on the pulse process itself?
The pulse process would block on the pulse semaphore, waiting for itself to complete the frame: an immediate deadlock.

To prevent this, Bloc checks if the active process is the host pulse process and raises an error (`denyPulseProcess`). Blocking waits must only be sent from external processes (Playground, SUnit, worker threads).

---

## 5. Attached elements vs Detached elements

Bloc maintains a clear separation between elements that are attached to a live space and elements that are not:

* **Attached elements:** Belong to an opened `BlSpace` (`element isAttachedToSceneGraph` is `true`). The pulse process owns them. You should modify them using `space deferAndSettle:` (in tests) or `space defer:` (from background threads). You cannot send `element forceLayout` to an attached element (it raises an error).
* **Detached elements:** Standalone element trees not in any space (`element isAttachedToSceneGraph` is `false`). There are no concurrency concerns here. You can mutate them directly, and you can calculate bounds synchronously with `element forceLayout` (for example, in headless unit tests or when exporting an element to a `Form` via `aeAsForm`).

---

## 6. Writing unit tests

When writing tests in Bloc:
- Subclass `BlSpaceTestCase`: its `setUp` creates a `space` on the headless host, opens it and settles it, and its `tearDown` closes it. The space is available with `self space`.
- Or subclass `BlParameterizedHostTest` to run the same tests on several hosts (see below). Use `self newTestingSpace` to get a clean space that is opened, settled, and automatically cleaned up in `tearDown`. `newTestingSpace` is defined by `BlParameterizedHostTest` only.
- Structure test assertions with `deferAndSettle:` (the example below is a `BlParameterizedHostTest`):

```smalltalk
testElementWidthChange
	| space element |
	space := self newTestingSpace.
	element := BlElement new.

	space deferAndSettle: [
		space root addChild: element.
		element extent: 100 @ 50 ].
	self assert: element extent equals: 100 @ 50.

	space deferAndSettle: [ element width: 200 ].
	self assert: element width equals: 200
```

### Parameterized Tests and Host Settings

`BlParameterizedHostTest` allows running tests across different host environments. In the Pharo Settings Browser (**Settings > Bloc > Hosts for parameterized tests**), you can configure which hosts are used:

- **Headless host only (Fast)** (`#headlessOnly`): The default setting. Tests run strictly against `BlHeadlessHost`. This is ideal for fast test feedback and CI environments where no display server is attached.
- **All available hosts** (`#allAvailable`): Runs each test method against every registered host backend (`BlHeadlessHost`, `BlOSWindowSDL2Host`, `BlMorphicHost`, etc.) to verify host-specific event loops and rendering.

You can also change this programmatically in scripts or test setups:
```smalltalk
BlParameterizedHostTest testHostsMode: #headlessOnly.
"or"
BlParameterizedHostTest testHostsMode: #allAvailable.
```

To test the interactions of your own project (headless host, synthetic mouse events, checking what is drawn), see [Testing Interactions and Drawing](TestingInteractions.md).

---

## What's Next?

To see practical UI patterns for worker threads, progress feedback, and data streaming, continue to:

👉 **[3. Building Non-Blocking UIs in Bloc](3-BuildingNonBlockingUIs.md)**
