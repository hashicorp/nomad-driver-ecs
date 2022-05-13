container {
  dependencies = false
  alpine_secdb = false
  secrets      = false
}

binary {
  secrets    = true
  go_modules = true
  osv        = true
  oss_index  = false
  nvd        = false
}
