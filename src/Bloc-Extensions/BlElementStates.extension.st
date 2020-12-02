Extension { #name : #BlElementStates }

{ #category : #'*Bloc-Extensions' }
BlElementStates >> gtStatesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'States';
		priority: 10;
		items: [
			(localStates asArray collect: [ :eachState | eachState -> #local ]),
			(inheritedStates asArray collect: [ :eachState | eachState -> #inherited ]) ];
		column: 'State' text: [ :assoc | assoc key ];
		column: 'Type' text: [ :assoc | assoc value ];
		updateWhen: #statesChanged in: self announcer
]
