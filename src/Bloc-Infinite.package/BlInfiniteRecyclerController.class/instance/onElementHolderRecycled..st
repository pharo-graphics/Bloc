recycler -> element
onElementHolderRecycled: anElementHolder

	self dataSource onElementRecycled: anElementHolder.
	self infoStore removeHolder: anElementHolder

	"			if (mRecyclerListener != null) {
                mRecyclerListener.onViewRecycled(holder);
            }
            if (mAdapter != null) {
                mAdapter.onViewRecycled(holder);
            }
            if (mState != null) {
                mViewInfoStore.removeViewHolder(holder);
            }"