// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: MPL-2.0

package ecs

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_taskStore(t *testing.T) {

	// Setup the new store and check it is empty.
	s := newTaskStore()
	assert.Empty(t, s.store, "new task store is not empty")

	// Test setting a new task handle and then reading it back out.
	s.Set("test-set-1", &taskHandle{})
	testHandle1, ok := s.Get("test-set-1")
	assert.NotNil(t, testHandle1, "test-set-1 is nil")
	assert.True(t, ok, "failed to get test-set-1")

	// Delete and read it back to ensure its gone.
	s.Delete("test-set-1")
	testHandle1, ok = s.Get("test-set-1")
	assert.Nil(t, testHandle1, "test-set-1 is not nil")
	assert.False(t, ok, "test-set-1 should not be available")
}
