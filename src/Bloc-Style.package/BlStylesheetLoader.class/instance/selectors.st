grammar selector
selectors
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]