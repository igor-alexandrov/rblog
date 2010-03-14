class Sanitize
  module Config
    RBLOG_BASIC = {
      :elements => [
        'a', 'b', 'blockquote', 'br', 'cite', 'code', 'dd', 'dl', 'dt', 'em',
        'h4', 'h5', 'h6', 'i', 'li', 'ol', 'p', 'pre', 'q', 'small', 'strike', 'strong', 'sub',
        'sup', 'u', 'ul', 'table', 'tbody', 'tr', 'td'],

      :attributes => {
        'a'          => ['href'],
        'blockquote' => ['cite'],
        'q'          => ['cite']
      },

      :add_attributes => {
        'a' => {'rel' => 'nofollow'}
      },

      :protocols => {
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto',
                                    :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    }
  end
end
