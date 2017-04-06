accessing
effect
	"Return currently applied effect.
	Note: I return an instance of BlNullEffect when there is no effect applied.
	effect can not be nil"
	<return: #BlElementEffect>

	^ self effectProperty value