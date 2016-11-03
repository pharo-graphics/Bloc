as yet unclassified
defaultSpec
	<spec: #default>
	^ SpecRowLayout composed
		newColumn: [ :col | 
			col
				add: #fpsLabel;
				add: #renderTimeLabel;
				add: #layoutTimeLabel;
				add: #eventTimeLabel ] width:200;
		newColumn: [ :col | 
			col
				add: #fps;
				add: #renderTime;
				add: #layoutTime;
				add: #eventTime ] width:50