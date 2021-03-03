Extension { #name : #BlTelemetrySignal }

{ #category : #'*Bloc-Extensions' }
BlTelemetrySignal >> gtMapFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Map';
		priority: 0;
		object: [ self task ];
		view: #gtMapFor:
]
