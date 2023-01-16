# deepl-clip-ruby
This small script will translate your current clipboard content into a pre defined target language using the deepl API. The current clipboard text will be replaced by the translated one. A free version is available for delevopers on https://www.deepl.com/de/pro/change-plan#developer. (500.000 characters limit per month atm)
## Installation using bundler
```zsh
bundle config set --local path 'vendor/bundle'
bundle install
```
Make shure that `xsel` is installed on your linux system

## Using the software

```zsh
git clone https://github.com/evait-security/deepl-clip-ruby
cd deepl-clip-ruby
```
### Edit config file
```zsh
cp config.example config.yml
```
Insert your API key and the target language to the new (untracked) `config.yml` file using your favourite editor.
### Running the tool
This simple call will convert your current clipboard into the target lang you defined in the config and sets the value of the clipboard to the translated text.

```zsh
bundler exec ruby deepl-clip.rb
```