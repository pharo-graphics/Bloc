I am an event dispatcher that directly dispatches events to the registered event handlers.
I do not support event bubbling. If you need events to be dispatched through a composition tree you might want to use ${class:BlBubblingEventDispatcher}$.

Example:

[[[

dispatcher := BlDirectEventDispatcher on: BlElement new.
dispatcher

]]]