class Identity
  attr_accessor :name, :description, :path

  def self.load_by_name(name)
    Rails.logger.info "Loading theme"
    if self.exist?(name) and self.valid?(name)
      theme = Theme.new
      theme.description = File.read("#{Theme.themes_root + name}/description.textile")
      theme.name = name
      theme
    else
      #TODO raise error here
      nil
    end

  end
  
  def self.identities_root
    "app/identities"
  end

  def self.glob_identities_root
    File.join(Rails.root, self.identities_root)
  end

  def self.installed_themes
    self.installed_themes_names.collect { |theme|
      Theme.load(theme)
    }
  end

  def self.installed_themes_names
    base_pathname = Pathname.new(self.identities_root)
    self.search_theme_directory.collect do |directory|
      Pathname.new(directory).relative_path_from(base_pathname).to_s
    end

  end

  def self.exist?(name)
    Pathname.new(themes_root + name).exist?
  end

  def self.valid?(name)
    File.readable?("#{themes_root + name}/theme.yml") and File.readable?("#{themes_root + name}/description.textile")
  end

  def path
    Theme.themes_root + self.name
  end

  def has?(type, value)
    case type
    when :layout
      Pathname.new(self.path + "/layouts/" + value +  ".html.erb").exist?
    end
  end

  def layout(layout_name)
    if self.has?(:layout, layout_name)
      Pathname.new("app/themes/test_theme_1/layouts/" + layout_name + ".html.erb").to_s
    else
      layout_name
    end
  end
  #Get description of theme
  #  def description
  #    File.read("#{path}/decscription.textile")
  #  end

  private
  def self.search_theme_directory
    glob = "#{self.identities_root}/[a-z0-9]*"
    Pathname.glob(glob).select do |path|
      File.readable?("#{path}/theme.yml") and File.readable?("#{path}/description.textile")
    end
  end
end #class Theme
