Extension { #name : #BlDevScripterReversedEvents }

{ #category : #'*Bloc-Extensions' }
BlDevScripterReversedEvents >> gtEventsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Events';
		priority: 3;
		items: [ self ];
		column: 'Index'
			text:
				[ :eachItem :eachIndex | (self reversedIndexFrom: eachIndex) asRopedText foreground: Color gray ]
			width: 80;
		column: 'Item'
			text: [ :eachItem | eachItem gtDisplayText ]
]
