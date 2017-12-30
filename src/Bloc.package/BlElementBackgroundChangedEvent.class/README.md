Is sent when element's background changes.

Example:

[[[
| element |

element := BlElement new.
element when: BlElementBackgroundChangedEvent do: [ self inform: 'Background changed' ].
element background: Color blue
]]]