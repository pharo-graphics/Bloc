The event is being propagated through the target's ancestor objects.

This process starts with the Space, then Root, then the Element, and so on through the elements until the target's parent is reached. Event listeners registered for capture mode when EventTarget addEventFilter: was called are triggered during this phase.