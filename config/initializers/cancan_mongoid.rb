# Cancan 1.6.10 / Rails 4.0.0 / Mongoid 4.0.0 do not interact in some critical way
# as to load the Cancan mongoid adapter.  I've registered this issue at:
# https://github.com/ryanb/cancan/issues/896
#
# In the meantime, we will complete the necessary requirements in an initializer...
require 'cancan/model_adapters/mongoid_adapter'
include CanCan::ModelAdditions::ClassMethods