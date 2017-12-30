Is sent by an element after it is added to the parent.

Note: I am not sent when element is re-attached!

Example:

[[[
| child parent |

child := BlElement new.
child when: BlElementAddedEvent do: [ self inform: 'Added to parent' ].

parent := BlElement new.
parent addChild: child.
]]]