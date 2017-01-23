geometry extent
size: aPoint
	| aLayoutConstraints |

	aLayoutConstraints := self constraints.
	(aLayoutConstraints horizontal resizer isExact and: [ 
		aLayoutConstraints horizontal resizer size = aPoint x 
			and: [ aLayoutConstraints vertical resizer isExact
				and: [ aLayoutConstraints vertical resizer size = aPoint y ] ] ])
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c |
		c horizontal exact: aPoint x.
		c vertical exact: aPoint y ]