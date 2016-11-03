as yet unclassified
emitValue: aMethodBuilder
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read: