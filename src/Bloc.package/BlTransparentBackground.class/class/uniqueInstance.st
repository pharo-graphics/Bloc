accessing
uniqueInstance
	"Return a unique instance of transparent backgrond.
	It is preferable to use unique instance than create a new every time"
	<return: #BlBackground>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]