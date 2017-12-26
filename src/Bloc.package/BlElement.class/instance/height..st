api - bounds
height: aNumber
	<event: #BlElementExtentChangedEvent>

	| aLayoutConstraints |

	aLayoutConstraints := self constraints.
	(aLayoutConstraints vertical resizer isExact and: [ 
		aLayoutConstraints vertical resizer size = aNumber ])
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c |
		c vertical exact: aNumber ]