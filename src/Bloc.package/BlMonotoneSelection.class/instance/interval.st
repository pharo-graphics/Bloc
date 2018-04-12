accessing
interval
	"Return current text selection as interval"
	<return: #Interval>
	self from ifNil: [ ^ 0 to: 0 ].
	^ self from to: self to