invalidation
markItemDecorInsetsDirty

	self cachedScrap do: [ :anElementHolder |
		anElementHolder itemElement constraints infinite insetsDirty: true ]