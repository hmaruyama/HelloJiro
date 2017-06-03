require 'julius'

voice_message = ''
julius = Julius.new
julius.each_message do |message, prompt|
  case message.name
  when :RECOGOUT
    voice_message = message.sentence
    puts voice_message
    if voice_message.include?("ニンニク")
      puts "にんにく♪───Ｏ（≧∇≦）Ｏ────♪"
    end
    break
  end
end
