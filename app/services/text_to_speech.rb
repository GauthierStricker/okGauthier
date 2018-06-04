require 'google/apis/texttospeech_v1beta1'
require 'media-magic'


include MediaMagic::Operations

class GoogleTextToSpeechService
	
  attr_accessor :text2speech
  def initialize
	@text2speech = Google::Apis::TexttospeechV1beta1::TexttospeechService.new 
	@text2speech.key = ENV['GOOGLE_API_KEY']
	@text2speech.request_options.skip_serialization = true
  end

  def call(text, filename)
   	request = {
			 "input": {
			  "text": text,
			 },
			 "voice": {
			  "languageCode": "fr-FR",
			  "name": "fr-FR-Standard-D",
			  "ssmlGender": "MALE"
			 },
			 "audioConfig": {
			  "audioEncoding": "mp3"
			 }
			}
	answer = @text2speech.synthesize_text_speech(request.to_json)
	path = "../assets/audios/" + filename + ".mp3"
	File.open(path,'w') do |f|
	  f.write(answer.audio_content)
	end
  end
end