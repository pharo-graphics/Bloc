accessing
uniqueInstance
	"Return unique instance of match resizer.
	Note: match resizer is stateless so it is preferable to share
	the same instance for memory and performance reasons"
	<return: #BlBackgroundMatchResizer>

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]