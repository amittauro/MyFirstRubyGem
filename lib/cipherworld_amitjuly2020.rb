require "cipherworld_amitjuly2020/version"

module CipherworldAmitjuly2020
  class Error < StandardError; end
  module Cipher

    class LetterNumber

      def initialize(char_set: ,key: )
        @char_set = char_set
        @key = key
      end

      def encrypt(string)
        begin
        # fetching letter and encrypting it
          ciphered = string.chars.map{|x| n = dictionary.fetch(x) + @key}
        rescue KeyError => e
          puts "Unsuitable text for cipher: #{e}"
        end
        # counter reset to 99
        ciphered = ciphered.map{|n|
        if n > 99 and n % 99 == 0
          n = 99
        elsif n > 99
          n %= 99
        else
          n
        end}
        # double digit for each letter encryption
        ciphered.map{ |x| x < 10? "0" + x.to_s : x }.join
      end

      def decrypt(encryptedtext)
        decrypted = encryptedtext.scan(/../).map{|x|
          n = ((x.to_i)-@key)%99
          decryptdict.fetch(n.to_s)}.join
      end

      private

      # obtaining character set
      def text_file
         list = []
         File.open(@char_set).each{|x| list.push(x)}
         list.delete_at(0)
         list
      end

      # creating dictionary from character set
      def dictionary
        character_set = {}
        text_file.each{|x| character_set[x[0]] = (x[3..4].to_i)}
        character_set
      end

      def decryptdict
        character_set = {}
        text_file.each.with_index{ |x,i| i < 9? character_set[x[3]] = x[0] :
            character_set[x[3..4]] = x[0] }
        character_set
      end

    end

    class LetterLetter < LetterNumber

      def initialize(char_set: )
        @char_set = char_set
      end

      def encrypt(string)
        # fetching letter and encrypting it
        #string.chars.each{|x| char_errors}
        begin
          ciphered = string.chars.map{|x| dictionary.fetch(x)}.join
        rescue KeyError => e
          puts "Unsuitable text for cipher: #{e}"
        end
      end

      def decrypt(encryptedtext)
        #string.chars.each{|x| decrypt_errors}
        begin
          ciphered = string.chars.map{|x| dictionary.fetch(x)}.join
        rescue KeyError => e
          puts "Unsuitable text for cipher: #{e}"
        end
        decrypted = encryptedtext.chars.map{|x| dictionary.key(x)}.join
      end

      private

      def dictionary
        character_set = {}
        text_file.each{|x| character_set[x[0]] = x[3]}
        character_set
      end

    end

  end

  input_array = ARGV

  begin
    info = File.read(input_array[2])
    info = info.gsub("\n","")
  rescue StandardError
    puts "No suitable text file for encryption/decryption"
  end

  char_set1 = "char_sets/character_set1.txt"
  char_set2 = "char_sets/character_set2.txt"

  if input_array[0] == "ll"
    l = Cipher::LetterLetter.new(char_set: char_set2)
  elsif input_array[0] == "ln"
    l = Cipher::LetterNumber.new(char_set: char_set1, key: input_array[3].to_i)
  else
    raise "Incorrect acronym for cipher method. Expect 'll' or 'ln'"
  end

  if input_array[1] == "enc"
    l = l.encrypt(info)
    File.open("#{input_array[2]}.enc","w") { |f| f.write(l)}
  elsif input_array[1] == "dec"
    l = l.decrypt(info)
    File.open("#{input_array[2][0..-5]}","w") { |f| f.write(l)}
  else
    raise "Incorrect acronym for encrypt or decrypt. Expect 'enc' or 'dec'"
  end

end
