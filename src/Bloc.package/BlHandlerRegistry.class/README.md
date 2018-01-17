I am an event handler registry used by dispatchers in order to manage event handlers.

Example:
[[[
| registry |
"one can use announcer based registry"
registry := BlHandlerAnnouncerRegistry new.
"or registry based on plain array"
registry := BlHandlerArrayRegistry new.
registry add: (BlEventHandler on: BlClickEvent do: [ self inform: 'Click' ] ).
registry add: (BlEventHandler on: BlMouseDownEvent do: [ self inform: 'Mouse down' ] ).
registry add: (BlEventHandler on: BlMouseUpEvent do: [ self inform: 'Mouse up' ] ).
registry dispatchEvent: BlClickEvent new.
registry dispatchEvent: BlMouseDownEvent new.
registry dispatchEvent: BlMouseUpEvent new.
]]]