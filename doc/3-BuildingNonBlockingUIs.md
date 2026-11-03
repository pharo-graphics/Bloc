# Building Non-Blocking UIs in Bloc

This guide shows practical patterns for building responsive user interfaces in **Bloc** (and widget libraries built on top of it, such as **Toplo**) when running background calculations, network requests, or database queries.

---

## 1. The Core Rule: Keep the pulse process free

In Bloc, each space is driven by a **host pulse process**. This process runs continuous frame cycles:
1. Lifecycle changes (`spacesToOpen`, `spacesToClose`)
2. Event dispatching (`eventQueue`)
3. Tasks and animations (`taskQueue`)
4. Layout calculations
5. Rendering onto the canvas

*(Pluggable custom phases registered by widget extensions—such as Toplo's skin installation and state application—execute between task processing and layout).*

> [!WARNING]
> Never do slow operations (HTTP requests, database queries, heavy loops) directly inside an event handler (such as a handler registered with `#addEventHandlerOn:do:` for `BlClickEvent`).
> Doing so blocks the host pulse loop: animations stop, windows cannot be resized, and the UI becomes unresponsive.

---

## 2. The 3-Step Asynchronous Pattern

Whenever an action takes noticeable time, organize the work across two processes: the **Host Pulse Process** (which owns the display and handles events) and a **Background Worker Process** (which performs the slow work).

```text
Pulse Process:   [Event Handler: show busy] ------------------------> [defer: show results]
                          \                                                  ^
                           \ (fork)                                         / (space defer:)
Worker Process:             +---------> [Fetch HTTP / Compute] ------------+
```

The workflow consists of three distinct steps:

1. **Step 1: Immediate UI Feedback (Host Pulse Process)**: Inside your event handler (e.g. `addEventHandlerOn: BlClickEvent do:`), provide immediate visual feedback before starting the slow operation. For example, update visual styling (`button background: Color veryLightGray`) and prevent repeated clicks (`button preventMouseEvents`).

   > [!NOTE]
   > **Why is direct mutation safe here without `#defer:`?**
   > Event handlers execute synchronously on the Space Pulse Process during the frame's Event Phase. Direct modifications to elements inside an event handler are completely thread-safe and take effect immediately in the upcoming layout and render passes of that same frame. Only code executing *outside* the pulse process (like a background worker) needs `#defer:`.

2. **Step 2: Heavy Computation or I/O (Background Worker Process)**: Fork a background process (`[ ... ] forkNamed: 'Worker'` or via TaskIt). Perform the slow HTTP request, database query, or computation off the pulse process so the UI remains interactive and animations continue running smoothly.

3. **Step 3: Synchronizing with the Space Process**: Because attached elements belong to the pulse loop, the background worker must **never** modify elements directly. Instead, send `space defer: [ ... ]`. The space enqueues the block into its task queue and requests a pulse, ensuring your update block executes safely during the pulse loop's task phase.

---

## 3. Practical Recipes

### Recipe 1: Simple Background Worker with `[ ... ] forkNamed:`

The most direct way to run work in the background without external libraries:

```smalltalk
| button count updateLabel |
button := BlTextElement new
	extent: 250 @ 40;
	background: Color lightGreen;
	editorMeasurement;
	yourself.

count := 0.
updateLabel := [ button text: ('Download report (', count asString, ')') asRopedText ].
updateLabel value.

button addEventHandlerOn: BlClickEvent do: [ :event |
	"1. On Pulse Process: Give immediate feedback (safe to modify element directly)"
	button
		background: Color veryVeryLightGray;
		text: 'Downloading...' asRopedText;
		preventMouseEvents.

	"2. Background Worker: Execute long-running I/O"
	[
		1 second wait. "Simulate slow I/O or network fetch"
		count := count + 1.

		"3. Defer back to the Space Pulse Process"
		button space defer: [
			updateLabel value.
			button
				background: Color lightGreen;
				allowMouseEvents ]
	] forkNamed: 'Download Worker'
].

button openInNewSpace.
```

---

### Recipe 2: Using TaskIt & Futures

If your application uses **TaskIt**, you can use promise-style callbacks with `#future`:

```smalltalk
| button longStuff |
button := BlTextElement new
	extent: 250 @ 65;
	background: Color lightBlue;
	text: ('Press me' asRopedText fontSize: 50);
	editorMeasurement;
	yourself.

longStuff := [
	1 second wait.
	{ [ 'Lucky you!' ]. [ self error: 'Try again!' ] } atRandom value ].

button addEventHandlerOn: BlClickEvent do: [ :event |
	"Disable button (safe to modify element directly on pulse process)"
	button
		background: Color lightGray;
		preventMouseEvents.

	longStuff future
		onSuccessDo: [ :result |
			button space defer: [
				button
					background: Color green;
					text: (result asRopedText fontSize: 50);
					allowMouseEvents ] ];
		onFailureDo: [ :anError |
			button space defer: [
				button
					background: Color red;
					text: (anError messageText asRopedText fontSize: 50);
					allowMouseEvents ] ]
].

button openInNewSpace.
```

---

### Recipe 3: Streaming High-Frequency Data

When receiving frequent updates from external sources (e.g., WebSockets, serial ports, or telemetry sockets), sending `space defer:` for every single packet can flood the pulse queue.

**Better approach:** Buffer incoming data and dispatch batch updates at most once per frame interval:

```smalltalk
socket onMessageReceived: [ :packet |
	incomingBuffer add: packet.

	"Throttle UI updates"
	isUpdateScheduled ifFalse: [
		isUpdateScheduled := true.
		space defer: [
			| batch |
			batch := incomingBuffer flushAll.
			isUpdateScheduled := false.
			self updateChartWithBatch: batch ] ]
].
```

---

## 4. Common Pitfalls and How to Avoid Them

### 1. The Master-Detail Selection Race
**The problem:**
1. User clicks **User 1** -> Starts async fetch for User 1.
2. User quickly clicks **User 2** -> Starts async fetch for User 2.
3. User 2's response arrives quickly and populates the detail view.
4. User 1's slow response finally arrives and overwrites User 2's view with stale data!

**The fix:** Compare the fetched item against the current selection before updating the view:
```smalltalk
userItemElement addEventHandlerOn: BlClickEvent do: [ :event |
	currentSelectedUser := selectedUser.
	detailElement background: Color lightGray.

	[
		| profileData |
		profileData := self fetchProfileFor: selectedUser.

		userItemElement space defer: [
			"Guard: only update if this item is still the active selection"
			currentSelectedUser = selectedUser ifTrue: [
				self displayProfile: profileData in: detailElement ] ]
	] forkNamed: 'Profile Fetcher'
].
```

---

### 2. Guarding against closed spaces ("Zombie Callbacks")
**The problem:** A background worker is running, but the user closes the space or navigates away before the worker finishes. If the worker attempts `element space defer:`, `element space` evaluates to `nil`, signalling `MessageNotUnderstood` and terminating the worker process with an unhandled exception.

**A fix:** Send `element deferIfAttachedToSceneGraph:`. It encapsulates both checks (guarding against closed spaces when scheduling, and verifying the element is still attached when the pulse executes):
```smalltalk
[
	| data |
	data := self fetchRemoteData.

	element deferIfAttachedToSceneGraph: [
		self updateViewWith: data.
		element allowMouseEvents ]
] forkNamed: 'Worker'
```

---

### 3. Search-as-you-type (Debounce & Cancellation)
**The problem:**
1. User types `"Ph"` -> Request 1 starts (takes 500ms).
2. User types `"Pharo"` -> Request 2 starts (takes 100ms).
3. Request 2 completes first and shows results for `"Pharo"`.
4. Request 1 completes later and overwrites the list with stale results for `"Ph"`.

**The fix:** Terminate the previous search process when new input arrives:
```smalltalk
searchElement addEventHandlerOn: BlTextInputEvent do: [ :event |
	| text |
	text := event text.

	"Cancel previous debounced or in-flight search"
	searchProcess ifNotNil: [ searchProcess terminate ].

	searchProcess := [
		200 milliSeconds wait. "Debounce typing"
		| results |
		results := self searchFor: text.

		searchElement space defer: [
			self displayResults: results in: resultsContainer ]
	] forkNamed: 'Search Worker'
].
```

Terminating the previous process provides two major advantages:
1. **Debouncing:** Rapid keystrokes terminate the sleeping worker before its `200 milliSeconds wait` expires, so only the final keystroke launches the search.
2. **Resource Savings:** If a slow query is already in flight, it is cancelled immediately instead of wasting CPU and network bandwidth.

---

### 4. Preventing Multiple Submissions
**The problem:** Rapidly clicking an action element forks multiple concurrent workers.

**The fix:** Prevent mouse events immediately on the first click:
```smalltalk
button addEventHandlerOn: BlClickEvent do: [ :event |
	button
		preventMouseEvents;
		background: Color veryLightGray.

	[
		[ self executeAction ] ensure: [
			button space defer: [
				button
					allowMouseEvents;
					background: Color lightGray ] ]
	] forkNamed: 'Action Worker'
].
```
