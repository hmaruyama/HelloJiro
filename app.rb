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

    request_body = {
      topping_name: "ninniku",
      mashi: 2
    }

    RestClient.post("http://localhost:3000/pigs/kabuki/topping_logs", request_body.to_json, {content_type: :json})
  end
end
