as yet unclassified
createDateEl
	^ BlText new
		text: '11:27 AM';
		fill: Color black;
		height:6;
		width: 40;
		margin: (BlInsets all: 4);
		constraintsDo: [ :c | c linear horizontal alignCenter];
		yourself