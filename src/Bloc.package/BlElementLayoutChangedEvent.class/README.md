Is sent when element's layout changes.

Example:

[[[
| element |

element := BlElement new.
element when: BlElementLayoutChangedEvent do: [ self inform: 'Layout changed' ].
element layout: BlBasicLayout new
]]]