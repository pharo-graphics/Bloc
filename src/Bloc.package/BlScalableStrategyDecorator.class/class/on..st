instance creation
on: aScalableStrategy
	"Create a new decorator instance that decorates a given strategy.
	aScalableStrategy must not be nil"
	<return: #BlScalableStrategyDecorator>

	^ self new strategy: aScalableStrategy