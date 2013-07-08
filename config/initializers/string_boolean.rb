# SimpleForm saves true and false as Strings rather than TrueClass and 
# FalseClass.  Until that is remedied, we will need to escape the value
# and convert the strings 'true' and 'false' to TrueClass and FalseClass.
#
# This code was gleaned from Github (https://gist.github.com/equivalent/3825916)
# but forked for preservation to (https://gist.github.com/acurley/5945680).
module StringToBoolean
  def to_bool
    return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
class String; include StringToBoolean; end
 
module BooleanToBoolean
  def to_bool;return self; end
end
 
class TrueClass; include BooleanToBoolean; end
class FalseClass; include BooleanToBoolean; end