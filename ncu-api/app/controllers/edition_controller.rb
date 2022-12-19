require 'openssl'

class EditionController < ApplicationController
    def add_or_edit
        #First: we make sure that the key is valid
        key = decrypt_key
        processedPass = params[:validationString]

        if (processedPass != key) then
            #Invalid
            head :unauthorized
            return
        end

        #main_page
        File.open("./main_pages/" + params[:fileName] + ".md", 'w') {|f| f.write params[:mainPage]}
        #side_panel
        File.open("./side_panels/" + params[:fileName] + ".md", 'w') {|f| f.write params[:sidePanel]}
    end

    private
    
    def decrypt_key
        key = nil
        iv = nil
        encrypted = nil

        File.open("./.key") {|f| key = Marshal.load(f)}
        File.open("./.iv") {|f| iv = Marshal.load(f)}
        File.open("./.key.enc") {|f| encrypted = Marshal.load(f)}

        decipher = OpenSSL::Cipher::AES.new(256, :CBC)
        decipher.decrypt
        decipher.key = key
        decipher.iv = iv

        decrypted = decipher.update(encrypted) + decipher.final
        return decrypted
    end
end