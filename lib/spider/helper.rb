module Spider
  module Helper
    def encode_to_utf8(str, source_encode)
      str.encode 'UTF-8', source_encode, invalid: :replace, undef: :replace, replace: ''
    end
  end
end
