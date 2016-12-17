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
	dataSourceChangeDuringMeasure := false.
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	preserveFocusAfterLayout := true.
	
	itemDecorations := OrderedCollection new.
	itemAnimator := self defaultItemAnimator.
	infoStore := self defaultInfoStore.
	infoStoreProcessor := self defaultInfoStoreProcessor on: self.
	state := self defaultState.
	childrenUpdateRunnable := self defaultChildrenUpdateRunnable on: self.
	overScrollMode := self defaultOverScrollMode.
	scrollFlinger := self defaultScrollFlinger on: self.
	self initializeChildrenManager.
	self initializeDataSource.
	self initializeRecycler.
	
	"Should be initialized last"
	layout infiniteElement: self.
	
	self initializeEventHandlers