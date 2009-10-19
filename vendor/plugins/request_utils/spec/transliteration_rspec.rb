require File.dirname(__FILE__) + '/../lib/requestutils'

describe String do
    before(:each) do
        @string = "Какой нибудь заголовок или name Of TAG"
    end

    it "should know how to transliterate" do
        translited_string = @string.transliterate
        translited_string.should == "Kakoy nibud zagolovok ili name Of TAG"
        @string.should == "Какой нибудь заголовок или name Of TAG"

        @string.transliterate!
        @string.should == "Kakoy nibud zagolovok ili name Of TAG"
    end

    it "should know how to transliterate_as_link" do
        transliterated_string = @string.transliterate_as_link
        transliterated_string.should == "kakoy-nibud-zagolovok-ili-name-of-tag"
        @string.should == "Какой нибудь заголовок или name Of TAG"

        transliterated_string = @string.transliterate_as_link("_")
        transliterated_string.should == "kakoy_nibud_zagolovok_ili_name_of_tag"
        @string.should == "Какой нибудь заголовок или name Of TAG"

        @string.transliterate_as_link!
        @string.should == "kakoy-nibud-zagolovok-ili-name-of-tag"
    end

end

