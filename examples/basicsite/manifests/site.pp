# Very basic manifest that delegates role selection to a fact
# In production systems this would usually be an ENC like foreman

class { "role::${role}": }