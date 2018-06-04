require 'google/apis/drive_v2'
require 'google/apis/texttospeech_v1beta1'
require 'media-magic'

include MediaMagic::Operations

class GoogleTextToSpeech
  def initialize(user)
    @user = user
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_LIST_ID']
  end

  def call
    @gibbon.lists(@list_id).members.create(
      body: {
        email_address: @user.email,
        status: "subscribed",
        # merge_fields: {
        #   FNAME: @user.first_name,
        #   LNAME: @user.last_name
        # }
      }
    )
  end
end


drive = Google::Apis::DriveV2::DriveService.new
text2speech = Google::Apis::TexttospeechV1beta1::TexttospeechService.new
text2speech.key = "AIzaSyDsaZrI6eVjmOWkTqD0iR3fZQEGC1Ue66Y"
text2speech.request_options.skip_serialization = true
request = {
 "input": {
  "text": "Lorem Ipsum",
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
 
answer = text2speech.synthesize_text_speech(request.to_json)

File.open('../assets/audios/output2.mp3','w') do |f|
  f.write(answer.audio_content)
end
