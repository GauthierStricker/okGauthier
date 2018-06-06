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
			  "text": "Je vous ai transmis mon CV, que vous pouvez retrouver dans le bas de page. Au delà des qualifications marketings exigées pour le poste et que je pense posséder, j’ai eu l’occasion de créer une startup sur le marché des chatbotes, et d’avoir le lead sur le produit. Cela m’a permis d’être fortement sensibilisé aux interfaces conversationnelles sur plusieurs aspects.
L’U X et les cas d'usage.. La technique derrière le produit.. Les bénéfices pour les utilisateurs.. Les limites de mise en application.. J'ai aussi pu analyser en profondeur le marché français et américain des assistants virtuels.
Enfin, je suis un early-adoptheure de la 1ère heure: J’ai brisé le coeur d’Alexa en août 2017. Depuis, tout les matins, mes premiers mots sont les mêmes. OK Google, stop le réveil.",
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
