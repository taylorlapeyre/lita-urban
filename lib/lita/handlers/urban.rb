module Lita
  module Handlers
    class Urban < Handler
      route(/urban( me)? (.*)/i, :define_word, command: true, help: {
        "urban (me) TERM" => "Defines a word using Urban Dictionary"
      })

      def define_word(response)
        term = response.matches[0][1]
        http_response = http.get("http://api.urbandictionary.com/v0/define", term: term)
        entry = MultiJson.load(http_response.body)["list"].first
        if entry
          response.reply(entry["definition"])
        else
          response.reply("No definition found for #{term}")
        end
      end
    end

    Lita.register_handler(Urban)
  end
end
