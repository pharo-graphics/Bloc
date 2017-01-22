accessing
uniqueInstance
	"Return a unique instance of transparent paint.
	It is preferable to use unique instance than create a new every time"
	<return: #BlColorPaint>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]