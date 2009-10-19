$KCODE = 'u'

module RequestUtils
  INSTALLATION_DIRECTORY = File.expand_path(File.dirname(__FILE__) + '/../') #:nodoc:
  MAJOR = 0
  MINOR = 1
  TINY = 0

  # Версия
  VERSION = [MAJOR, MINOR ,TINY].join('.') #:nodoc:

  # Стандартный маркер для подстановок - invalid UTF sequence
  SUBSTITUTION_MARKER = "\xF0\xF0\xF0\xF0" #:nodoc:

  def self.load_component(name) #:nodoc:
    require File.join(RequestUtils::INSTALLATION_DIRECTORY, "lib", name.to_s, name.to_s)
  end

  def self.reload_component(name) #:nodoc:
    load File.join(RequestUtils::INSTALLATION_DIRECTORY, "lib", name.to_s, "#{name}.rb")
  end
end

RequestUtils::load_component :transliteration
RequestUtils::load_component :xml
