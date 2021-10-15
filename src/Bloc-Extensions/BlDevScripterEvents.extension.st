Extension { #name : #BlDevScripterEvents }

{ #category : #'*Bloc-Extensions' }
BlDevScripterEvents >> gtEventsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Events';
		priority: 3;
		items: [ self ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 80;
		column: 'Item'
			text: [ :eachItem | eachItem gtDisplayText ]
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterEvents >> gtReveresedEventsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ (self reversed gtEventsFor: aView)
		title: 'Events (Reversed)';
		priority: 4
]
