require 'clipboard'
require 'net/http'
require 'json'
require 'yaml'

unless File.file?('config.yml')
  puts "[-] no config file found"
  exit(1)
end

# load config file
configuration = YAML.safe_load(File.read('config.yml'))
deepl_api_key = configuration["deepl_api_key"]
target_lang = configuration["target_lang"]

if deepl_api_key.empty?
  puts "[-] no deepl api key defined"
  exit(1)
end

if target_lang.empty?
  puts "[*] no target lang found, switching to EN as default value"
  target_lang = "EN"
end

# Get clipboard text
clipboard_text = Clipboard.paste

# Set up DeepL API endpoint
uri = URI('https://api-free.deepl.com/v2/translate')
headers = { "Authorization" => "DeepL-Auth-Key #{deepl_api_key}"}

# Prepare the request
req = Net::HTTP::Post.new(uri, headers)
params = { :text => clipboard_text, :target_lang => target_lang }
req.body = URI.encode_www_form(params)

# Send the request and parse the response
res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
  http.request(req)
}
json_response = JSON.parse(res.body)
Clipboard.copy json_response['translations'][0]['text']
exec('notify-send "Translation moved to clipboard"')