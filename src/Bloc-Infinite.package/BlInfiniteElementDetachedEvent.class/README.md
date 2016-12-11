Sent when an element is detached from InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: BlInfiniteElementDetachedEvent
	do: [ :event | self inform: 'Detached: ', event element asString ]