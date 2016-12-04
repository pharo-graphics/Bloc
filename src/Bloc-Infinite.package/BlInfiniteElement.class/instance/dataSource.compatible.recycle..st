private - accessing
dataSource: aNewDataSource compatible: isCompatibleWithPrevious recycle: shouldRecycleElement
	

	"		if (mAdapter != null) {
            mAdapter.unregisterAdapterDataObserver(mObserver);
            mAdapter.onDetachedFromRecyclerView(this);
        }
        if (!compatibleWithPrevious || removeAndRecycleViews) {
            // end all running animations
            if (mItemAnimator != null) {
                mItemAnimator.endAnimations();
            }
            // Since animations are ended, mLayout.children should be equal to
            // recyclerView.children. This may not be true if item animator's end does not work as
            // expected. (e.g. not release children instantly). It is safer to use mLayout's child
            // count.
            if (mLayout != null) {
                mLayout.removeAndRecycleAllViews(mRecycler);
                mLayout.removeAndRecycleScrapInt(mRecycler);
            }
            // we should clear it here before adapters are swapped to ensure correct callbacks.
            mRecycler.clear();
        }
        mAdapterHelper.reset();
        final Adapter oldAdapter = mAdapter;
        mAdapter = adapter;
        if (adapter != null) {
            adapter.registerAdapterDataObserver(mObserver);
            adapter.onAttachedToRecyclerView(this);
        }
        if (mLayout != null) {
            mLayout.onAdapterChanged(oldAdapter, mAdapter);
        }
        mRecycler.onAdapterChanged(oldAdapter, mAdapter, compatibleWithPrevious);
        mState.mStructureChanged = true;
        markKnownViewsInvalid();"