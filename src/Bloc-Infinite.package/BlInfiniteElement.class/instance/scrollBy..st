scrolling
scrollBy: aPoint 
	| canScrollHorizontal canScrollVertical |

	layoutFrozen
		ifTrue: [ ^ self ].
		
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			self scrollByInternal: (canScrollHorizontal
				ifTrue: [ aPoint x ]
				ifFalse: [ 0 ]) @ (canScrollVertical
					ifTrue: [ aPoint y ]
					ifFalse: [ 0 ])
					from: nil ]