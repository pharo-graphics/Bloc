initialization
initialize
	super initialize.
	
	hasFixedSize := false.
	firstLayoutComplete := false.
	layoutOrScrollCounter := 0.
	dispatchScrollCounter := 0.
	eatRequestLayoutCounter := 0.
	layoutFrozen := false.
	layoutRequestEaten := false.
	dataSourceChangedAfterLayout := false.
	dataSourceChangedDuringMeasure := false.
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	preserveFocusAfterLayout := true.
	
	infoStore := self defaultInfoStore.
	state := self defaultState.
	self initializeChildrenManager.
	self initializeDataSource.
	self initializeRecycler.
	
	"Should be initialized last"
	layout infiniteElement: self