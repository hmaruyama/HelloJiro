require 'julius'
require 'rest-client'
require 'json'

topping_types = {
  ninniku: "ニンニク",
  yasai: "ヤサイ",
  abura: "アブラ",
  tare: "カラメ"
}
quantity = {
  mashi: "マシ",
  mashimashi: "マシマシ"
}

voice_message = ''
julius = Julius.new
puts "...ok!"
puts "呪文を唱えてください。"
julius.each_message do |message, prompt|
  case message.name
  when :RECOGOUT
    voice_message = message.sentence
    puts "次の方トッピングなにしますか〜？ : #{voice_message.gsub(',', '')}"

    words = voice_message.split(',')


    topping_types.each do |key, value|
      topping_code = key
      topping_name = value

      topping_index = words.index(topping_name)
      unless topping_index.nil?
        if words[topping_index+1] == quantity[:mashimashi]
          mashi_count = 2
        else
          mashi_count = 1
        end

        request_body = {
          topping_name: topping_code,
          mashi: mashi_count
        }

        RestClient.post("http://localhost:3000/pigs/kabuki/topping_logs", request_body.to_json, {content_type: :json})
      end
    end
  end
end
