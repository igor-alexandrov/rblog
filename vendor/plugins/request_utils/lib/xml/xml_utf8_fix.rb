# class Fixnum #:nodoc:
#   XChar = Builder::XChar if ! defined?(XChar)
# 
#   # XML escaped version of chr (inlines cyrillic unicode range)
#   def xchr
#     n = XChar::CP1252[self] || self
#     n = 42 unless XChar::VALID.find {|value| value.kind_of?(Range) ? value.include?(n) : (value == n)}
# 
#     XChar::PREDEFINED[n] or case n
#       when 0...128
#         n.chr
#       when 0x400..0x4FF
#         [n].pack 'U'
#       else
#         "&##{n};"
#       end
#   end
# end