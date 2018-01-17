accessing
availableRegistryClasses
	<return: #Collection of: #'BlHandlerRegistry class'>

	^ self allSubclasses select: [ :aRegistryClass | aRegistryClass isSupported ]