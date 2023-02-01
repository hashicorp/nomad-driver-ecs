// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: MPL-2.0

package ecs

import (
	"sync"
)

// taskStore is where we store individual task handles using a lock to ensure
// updates are safe.
type taskStore struct {
	store map[string]*taskHandle
	lock  sync.RWMutex
}

// newTaskStore builds a new taskStore for use.
func newTaskStore() *taskStore {
	return &taskStore{store: map[string]*taskHandle{}}
}

// Set is used to insert, safely, an entry into the taskStore.
func (ts *taskStore) Set(id string, handle *taskHandle) {
	ts.lock.Lock()
	defer ts.lock.Unlock()
	ts.store[id] = handle
}

// Get returns a taskHandle, if it exists in the taskStore based on a passed
// identifier.
func (ts *taskStore) Get(id string) (*taskHandle, bool) {
	ts.lock.RLock()
	defer ts.lock.RUnlock()
	t, ok := ts.store[id]
	return t, ok
}

// Delete removes an entry from the taskStore if it exists.
func (ts *taskStore) Delete(id string) {
	ts.lock.Lock()
	defer ts.lock.Unlock()
	delete(ts.store, id)
}
