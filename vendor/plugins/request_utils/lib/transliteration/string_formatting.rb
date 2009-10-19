module RequestUtils
    module Transliteration #:nodoc:
    end
end

module RequestUtils::Transliteration::StringFormatting

    #Транслитерация строки
    def transliterate
        RequestUtils::Transliteration::transliterate(self.to_s)
    end

    def transliterate!
        self.replace(self.transliterate)
    end

    def transliterate_as_link(delimiter='-')
        RequestUtils::Transliteration::transliterate_as_link(self.to_s, delimiter)
    end

    def transliterate_as_link!(delimiter='-')
        self.replace(self.transliterate_as_link(delimiter))
    end
end

class Object::String
    include RequestUtils::Transliteration::StringFormatting
end